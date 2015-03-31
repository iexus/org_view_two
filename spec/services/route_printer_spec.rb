require 'spec_helper'
require 'services/route_printer'

describe RoutePrinter do
  describe '#print_route' do
    let(:employees) { [batman, cat_woman, invisible_woman, danger_mouse, superman] }
    let(:batman) { Employee.new(1, "Batman", 2) }
    let(:cat_woman) { Employee.new(2, "Catwoman", 3) }
    let(:invisible_woman) { Employee.new(3, "Invisible woman", 4) }
    let(:danger_mouse) { Employee.new(4, "Danger mouse", nil) }
    let(:superman) { Employee.new(5, "Superman", 4) }

    let(:longer_route) { "Batman (1) -> Catwoman (2) -> Invisible woman (3) -> Danger mouse (4) <- Superman (5)" }
    let(:short_route) { "Batman (1) -> Catwoman (2)" }
    let(:short_route_down) { "Catwoman (2) <- Batman (1)" }

    it 'will print a person with their employee id in the format <name> (id)' do
      expect(subject.print_route([batman])).to eq "Batman (1)"
    end

    it 'will print -> to show a move to a boss' do
      expect(subject.print_route([batman, cat_woman])).to eq short_route
    end

    it 'will print <- to show a move from a boss to employee' do
      expect(subject.print_route([cat_woman, batman])).to eq short_route_down
    end

    it 'will print both up and down for a longer journey' do
      expect(subject.print_route(employees)).to eq longer_route
    end
  end
end
