require 'spec_helper'
require 'services/org_hierarchy'

describe OrgChart do
  describe '#find_path' do
    let(:expected_result) { "Batman (16) -> Black Widow (6) -> Gonzo the Great (2) -> Dangermouse (1) <- Invisible Woman (3) <- Super Ted (15)" }
    let(:batman_name) { "Batman" }
    let(:super_ted_name) { "Super Ted" }
    let(:org_parser) { double :org_parser }

    let(:employees) do
      [
        Employee.new(16, "Batman", 6),
        Employee.new(6, "Black Widow", 2),
        Employee.new(2, "Gonzo the Great", 1),
        Employee.new(1, "Dangermouse", nil),
        Employee.new(3, "Invisible Woman", 1),
        Employee.new(15, "Super Ted", 3)
      ]
    end

    before do
      allow(org_parser).to receive(:parse_employees).and_return(employees)
    end

    it 'will plot the route between 2 employees' do
      org_chart = OrgChart.new(org_parser)
      expect(org_chart.find_path("a_file", batman_name, super_ted_name)).to eq expected_result
    end
  end
end
