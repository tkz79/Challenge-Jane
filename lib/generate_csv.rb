# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'csv'

class GenerateCSV
  attr_reader :path, :count

  def initialize(path:, count: 1000)
    @path = path
    @count = count
  end

  def generate
    CSV.open(path, 'wb') do |csv|
      count.times { csv << generate_row }
    end
  end

  private

  def generate_row
    [
      [Faker::Name.first_name, Faker::Name.last_name].join(' '),
      Faker::Internet.free_email,
      rand(99),
      %w[m f].sample
    ]
  end
end
