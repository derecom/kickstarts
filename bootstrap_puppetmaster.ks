install
cdrom
lang en_US.UTF-8
keyboard us
network --bootproto=dhcp
rootpw --iscrypted x
firewall --enabled --service=ssh
authconfig --enableshadow --passalgo=sha512
selinux --enforcing
timezone UTC
bootloader --location=mbr

text
skipx
zerombr

clearpart --all --initlabel
part /boot --size=512 --asprimary --fstype=ext4 --recommended
part pv.01 --grow --size=100
volgroup os pv.01
logvol swap --vgname=os --name=swap --fstype=swap --size=1024 --recommended
logvol / --vgname=os --name=root --fstype=ext4 --size=100 --grow

firstboot --disabled
reboot

%packages --nobase
@core
%end

%post
/usr/bin/yum -y install sudo
/usr/sbin/useradd ops -U -G wheel
echo "ops        ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers.d/ops
chmod 0440 /etc/sudoers.d/ops

mkdir --mode=700 ~ops/.ssh
echo "ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQDMxMPne9PviTcZGv4cqglPhS98mNELf+dutJrbNSwZX46aUt/HbSx/nOX0i/9c0F5cNHek+y/tTa1myhnDfpIiYcuWtp+G79syQQn/5DUT0/qD6WX49YGKHGEDXaL6a7UvXxsfwcsEw8czMESXeErTg0+FLIKjYeHIcHWIJYuQ69wFKCcaBW4wCmT2fW5DAzldpYTjrK3miC4lLfnIf3nspJe/h1jcQHXOxbu4/OdYhfAL2zXroaw09CQGkV6Zyv7Bz1412ZRp1IHCZypJbv0gHtMyJMRGbZLWqm9vxxBhff9woMqIYiDTURXGdhLU0Om4h5MCQiN5+3P8zOnGJWvP
ops@derecom.it" >> ~ops/.ssh/authorized_keys
chmod 0600 ~ops/.ssh/authorized_keys
chown -R ops:ops ~ops/.ssh
restorecon -R ~ops/.ssh

%end

