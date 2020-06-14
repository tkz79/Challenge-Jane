# frozen_string_literal: true

require 'parse_csv'
require 'pry'

RSpec.describe 'parse_csv' do # rubocop:disable Metrics/BlockLength
  subject(:parser) { ParseCSV.new(file_name: fixture, column: column) }

  let(:fixture) { 'spec/fixtures/mini_roster.csv' }
  let(:column) { 1 }

  describe 'defines its attr_readers' do
    it 'defines #column' do
      expect(parser.column).to eq(1)
    end

    it 'defines #file' do
      expect(parser.file_name).to eq('spec/fixtures/mini_roster.csv')
    end

    it 'defines #results' do
      expect(parser.results).to eq({})
    end
  end

  describe '#parse' do
    let(:expected_result) do
      {
        'gmail.com' => 3,
        'hotmail.com' => 2,
        'yahoo.com' => 2
      }
    end

    it 'returns the expected results hash' do
      parser.parse
      expect(parser.results).to eq(expected_result)
    end
  end
end
