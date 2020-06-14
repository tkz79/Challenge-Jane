# frozen_string_literal: true

require 'optparse'

# ScriptOptions wrapper
class ParseOptions
  VERSION = '1.0.0'

  attr_reader :parser, :options

  # @param +args+ [Array]
  def parse(args:)
    @options = ScriptOptions.new
    @args = OptionParser.new do |parser|
      @options.define_options(parser)
      parser.parse!(args)
    end

    @options
  end

  # Provides easier access to options and arguments from the command line
  class ScriptOptions
    attr_accessor :argument, :csv_source, :verbose

    def initialize
      self.argument = nil
      self.csv_source = 'fixture' # Default source is the spec fixture
      self.verbose = false
    end

    # @param +parser+ [OptionParser]
    def define_options(parser) # rubocop:disable Metrics/MethodLength
      executable_name = File.split($PROGRAM_NAME)[1]
      parser.banner = <<~HELP
        Parses a csv file and counts domains used in the email addresses of the
        second column. The application will parse the fixture file by default,
        or use the file option to pass a file name to parse a specific file.

        See README.md for more details
        Usage: #{executable_name} -v (-i <filepath> | -h | --version)
        Options are:
      HELP
      parser.separator ''
      parser.separator 'Specific options:'

      file_path_option(parser)

      parser.separator ''
      parser.separator 'Common options:'

      help_option(parser)
      verbose_option(parser)
      version_option(parser)
    end

    # @param +parser+ [OptionParser]
    def file_path_option(parser)
      msg = 'Parse a specific CSV file: Provide a complete file path'
      parser.on('-i', '--input FILE', String, msg) do |file|
        self.csv_source = 'input'
        self.argument = file
      end
    end

    # @param +parser+ [OptionParser]
    def help_option(parser)
      parser.on_tail('-h', '--help', 'Show help message') do
        puts parser
        exit
      end
    end

    # @param +parser+ [OptionParser]
    def verbose_option(parser)
      parser.on('-v', '--verbose', 'Run verbosely') do |v|
        self.verbose = v
      end
    end

    # @param +parser+ [OptionParser]
    def version_option(parser)
      parser.on_tail('--version', 'Show version') do
        puts ParseOptions::VERSION
        exit
      end
    end
  end
end
