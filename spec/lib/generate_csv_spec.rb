# frozen_string_literal: true

require 'spec_helper'
require 'csv'
require 'generate_csv'

RSpec.describe 'generate_csv', type: :aruba do # rubocop:disable Metrics/BlockLength
  subject(:generator) { GenerateCSV.new(path: path, count: count) }

  describe 'defines its attr_readers' do
    let(:path) { 'file.csv' }
    let(:count) { 1 }

    it 'defines #count' do
      expect(generator.count).to be(count)
    end

    it 'defines #path' do
      expect(generator.path).to be(path)
    end
  end

  describe '#generate' do
    let(:path) { 'file.csv' }
    let(:count) { 5 }

    before do
      setup_aruba
      Dir.chdir('tmp/aruba')
    end
    after do
      Dir.chdir('../..')
    end

    it 'adds rows to a csv file' do
      file = File.new(path, 'w')
      generator.generate
      expect(CSV.read(file).count).to eq(count)
    end
  end
end
