# De.re.com Kickstarts

This repository contains a collection of kickstart files used for various
purposes across de.re.com infrastructure.

## Kickstart Catalog

* `bootstrap_puppetmaster.ks`: used to bootstrap the initial puppetmaster
  responsible of managing all subsequent infrastructure actors.
* `generic_rhel_server.ks`: a generic and very minimal kickstart for RHEL and
  derivatives; suitable as a base for specialized kickstarts.

## Supported Architectures

Currently, the kickstarts have been tested only on CentOS 6.4 x86\_64. They
should be generic enough to run on most compatible platforms. However, there
are cases such PuppetLabs YUM repo release rpm installation that are done
referencing specific OS name and/or architecture, and are at the moment not
smart enough to detect where they're running.
