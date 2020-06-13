# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'csv'

def parse_file
  data = File.read('spec/fixtures/roster.csv')

  write_file(domain_counts)
end

def write_file(domain_counts)

end
