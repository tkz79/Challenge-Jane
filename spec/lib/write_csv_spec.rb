# frozen_string_literal: true

require 'spec_helper'
require 'csv'
require 'write_csv'

RSpec.describe 'write_csv', type: :aruba do # rubocop:disable Metrics/BlockLength
  subject(:writer) { WriteCSV.new }

  before do
    setup_aruba
    Dir.chdir('tmp/aruba')
  end
  after do
    Dir.chdir('../..')
  end

  describe 'defines its attr_readers' do
    it 'defines #results' do
      expect(writer.file).to be_a(File)
    end
  end

  describe '#write_results' do # rubocop:disable Metrics/BlockLength
    let(:results) do
      {
        'gmail.com' => 3,
        'hotmail.com' => 2,
        'yahoo.com' => 2
      }
    end

    context 'when headers are provided' do
      let(:headers) { %w[domain count] }
      let(:expected_result) do
        [
          %w[domain count],
          %w[gmail.com 3],
          %w[hotmail.com 2],
          %w[yahoo.com 2]
        ]
      end

      it 'correcty writes contents of file' do
        writer.write_results(headers: headers, results: results)
        expect(CSV.read(writer.file)).to eq(expected_result)
      end
    end

    context 'when headers are not provided' do
      let(:expected_result) do
        [
          %w[gmail.com 3],
          %w[hotmail.com 2],
          %w[yahoo.com 2]
        ]
      end

      it 'correcty writes contents of file' do
        writer.write_results(results: results)
        expect(CSV.read(writer.file)).to eq(expected_result)
      end
    end
  end
end
