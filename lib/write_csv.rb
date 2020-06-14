# frozen_string_literal: true

# Creates a csv file with the results
class WriteCSV
  attr_reader :file

  def initialize
    time_stamp = Time.now.to_i
    file_name = "output_#{time_stamp}.csv"
    @file = File.new(file_name, 'w')
  end

  # @param +headers+ [Array]
  # @param +results+ [Hash]
  def write_results(headers: nil, results:)
    @file.puts(headers.join(',')) if headers
    results.each { |result| @file.puts(result.join(',')) }
    @file.close
  end
end
