# vim: syntax=ruby

require 'thor'
require 'fileutils'
require 'erb'

class Kickstart < Thor
  desc "new NAME TEMPLATE", "Create a new kickstart (optionally inheriting from a template)"
  def new(name, src)
    @name = name
    ks_file = "#{@name}.ks"
    src_template = "#{src}.ks.erb"

    unless File.exists? src_template
      puts "Cannot clone from #{src_template}: no such file or directory"
      exit
    end

    if File.exists? ks_file
      puts "Destination #{ks_file} already exists, not overriding."
      exit
    end

    puts "Generating new kickstart #{ks_file} based on #{src} template"

    erb_template = ""
    File.open(src_template, 'r') do |tpl|
      erb_template = tpl.read
    end

    output = ERB.new(erb_template).result(binding)
    File.open(ks_file, 'w') do |ks|
      ks << output
    end
  end

  desc "publish", "Publish the kickstarts on GitHub Pages"
  def publish
    kickstarts = `git ls-tree -r --name-only master`.split.select { |f| f =~ /.ks$/ }

    system "git checkout gh-pages"
    kickstarts.each do |ks|
      system "git checkout master -- #{ks}"
      system "git add -u #{ks}"
    end
    system "git commit -m 'Kickstart catalog updated at #{Time.now.strftime('%Y-%m-%d')}"
  end
end
