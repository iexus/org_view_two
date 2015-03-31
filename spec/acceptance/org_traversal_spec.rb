require 'spec_helper'
require 'org_chart'
require 'services/employee_file_parser'

describe 'Traversing the organisation' do
  let(:expected_result) { "Batman (16) -> Black Widow (6) -> Gonzo the Great (2) -> Dangermouse (1) <- Invisible Woman (3) <- Super Ted (15)" }
  let(:file_path) { "./spec/fixtures/super_hero.txt" }
  let(:batman) { "Batman" }
  let(:super_ted) { "Super Ted" }

  it 'will plot a route between 2 employees' do
    org_chart = OrgChart.new(EmployeeFileParser.new)
    expect(org_chart.find_path(file_path, batman, super_ted)).to eq expected_result
  end
end
