#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'parse_options'

# Main wrapper for script
def main
  options = parse_options(args: ARGV)

  exit 0
end

# @pram +args+ [Array]
# @return [ScriptOptions]
def parse_options(args:)
  ParseOptions.new.parse(args: args)
rescue OptionParser::InvalidOption => e
  warn e.message
  exit(1)
rescue OptionParser::MissingArgument => e
  warn e.message
  exit(2)
end

main
