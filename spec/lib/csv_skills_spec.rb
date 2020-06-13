# frozen_string_literal: true

require 'csv_skills'

RSpec.describe 'csv_skills' do
  let(:expected_csv_contents) do
    [
      %w[domain count],
      %w[yahoo.com 331],
      %w[gmail.com 330],
      %w[hotmail.com 339]
    ]
  end

  it 'generates a count of the domains used in email addresses' do
    parse_file

    expect(CSV.read('output.csv')).to eq(expected_csv_contents)
  end
end
