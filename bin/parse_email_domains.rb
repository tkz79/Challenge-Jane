#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'parse_csv'
require 'parse_options'

EMAIL_COLUMN = 1

# Main wrapper for script
def main
  options = parse_options(args: ARGV)

  csv_parser = build_csv_parser(options)
  parse_csv(csv_parser)

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

# @pram +options+ [ScriptOptions]
# @return [ParseCSV]
def build_csv_parser(options)
  file_name = source_file_path(options)
  ParseCSV.new(file_name: file_name, column: EMAIL_COLUMN)
end

# @pram +options+ [ScriptOptions]
def source_file_path(options)
  case options.csv_source
  when 'input' then options.argument
  when 'fixture' then "#{__dir__}/../spec/fixtures/roster.csv"
  end
end

# @pram +csv_parser+ [ParseCSV]
def parse_csv(csv_parser)
  csv_parser.parse
rescue Errno::ENOENT => e
  warn e.message
  exit(3)
rescue Errno::EACCES => e
  warn e.message
  exit(4)
rescue CSV::MalformedCSVError => e
  warn e.message
  exit(5)
end

main
