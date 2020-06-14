# frozen_string_literal: true

require 'csv'

# Takes a file_name for a csv to parse, and returns a hash of the domains used
class ParseCSV
  attr_reader :column, :file_name, :results

  # @param +file_name+ [String]
  # @param +column+ [Integer]
  def initialize(file_name:, column:)
    @column = column
    @file_name = file_name
    @results = {}
  end

  def parse
    CSV.foreach(file_name) do |row|
      email_address = row[column]
      next unless email_address

      domain = extract_domain(email_address)
      next unless domain

      update_results(domain)
    end
  end

  private

  # @param +email_address+ [String]
  # @return [nil|String]
  def extract_domain(email_address)
    return nil unless email_address =~ URI::MailTo::EMAIL_REGEXP

    email_address.split('@')[1]
  end

  # @param +domain+ [String]
  def update_results(domain)
    if results.key?(domain)
      results[domain] += 1
    else
      results[domain] = 1
    end
  end
end
