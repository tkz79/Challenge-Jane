#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'parse_csv'
require 'parse_options'
require 'write_csv'

EMAIL_COLUMN = 1
HEADER_LABELS = %w[domain count].freeze

# Main wrapper for script
def main
  options = parse_options(args: ARGV)

  csv_parser = build_csv_parser(options)
  parse_csv(csv_parser)

  result_writer = build_result_writer
  write_results(csv_parser, result_writer)

  puts "results saved in file: #{File.absolute_path(result_writer.file)}" if options.verbose

  exit 0
end

# @pram +args+ [Array]
# @return [ScriptOptions]
def parse_options(args:)
  ParseOptions.new.parse(args: args)
rescue OptionParser::InvalidOption => e
  rescue_exit(e, 1)
rescue OptionParser::MissingArgument => e
  rescue_exit(e, 2)
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
  rescue_exit(e, 3)
rescue Errno::EACCES => e
  rescue_exit(e, 4)
rescue CSV::MalformedCSVError => e
  rescue_exit(e, 5)
end

def build_result_writer
  WriteCSV.new
rescue Errno::EACCES => e
  rescue_exit(e, 6)
end

# @pram +csv_parser+ [ParseCSV]
# @pram +results_writer+ [WriteCSV]
def write_results(csv_parser, results_writer)
  results_writer.write_results(headers: HEADER_LABELS, results: csv_parser.results)
end

# @pram +exception+ [*Exception]
# @pram +code+ [Integer]
def rescue_exit(exception, code)
  warn exception.message
  exit(code)
end

main
