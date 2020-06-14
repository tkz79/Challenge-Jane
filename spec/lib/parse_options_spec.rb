# frozen_string_literal: true

require 'parse_options'

RSpec.describe 'parse_options' do # rubocop:disable Metrics/BlockLength
  subject { ParseOptions.new.parse(args: args) }

  let(:args) { [] }

  describe 'defines its attr_readers' do
    it 'defines #argument' do
      expect(subject.argument).to eq(nil)
    end

    it 'defines #csv_source' do
      expect(subject.csv_source).to eq('fixture')
    end

    it 'defines #verbose' do
      expect(subject.verbose).to eq(false)
    end
  end

  describe '#parse' do
    it 'returns a ScriptOptions object' do
      expect(subject).to be_a(ParseOptions::ScriptOptions)
    end

    context 'when the input option is set' do
      subject { ParseOptions.new.parse(args: args) }

      let(:args) { ['-i', 'spec/fixtures/mini_roster.csv'] }

      it 'defines #argument' do
        expect(subject.argument).to eq('spec/fixtures/mini_roster.csv')
      end

      it 'defines #csv_source' do
        expect(subject.csv_source).to eq('input')
      end
    end
  end
end
