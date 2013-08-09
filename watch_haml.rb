#!/usr/bin/ruby1.8
# Script to watch a directory for any changes to a haml file
# and compile it.
#
# USAGE: ruby watch_haml.rb <directory_to_watch>
#
# Original by Blake Smith / http://blakesmith.github.com/2010/09/05/haml-directory-watcher.html

require 'rubygems'
require 'fssm'
require 'haml'
require 'time'

# directory = ARGV.first
directory = Dir.pwd
FSSM.monitor(directory, '**/*.haml') do
  update do |base, relative|
    input = open("#{base}/#{relative}").read
    output = open("#{base}/#{relative.gsub!('.haml', '.html')}", 'w')
    output.write(Haml::Engine.new(input).render)
    output.close
    puts Time.now
  end
end