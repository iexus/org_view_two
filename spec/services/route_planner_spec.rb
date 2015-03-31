describe RoutePlanner do

  describe '#calculate_route' do
    describe 'simple one jump tree' do
      let(:org_hierarchy) { OrgHierarchy.new(employees) }
      let(:employees) { [boss_emp, start_emp, end_emp] }
      let(:boss_emp) { Employee.new(1, "the boss", nil) }
      let(:start_emp) { Employee.new(2, "start", 1) }
      let(:end_emp) { Employee.new(3, "end", 1) }

      it 'will return a route between 2 employees' do
        planner = RoutePlanner.new(org_hierarchy)
        expect(planner.calculate_route(start_emp, end_emp)).to eq [start_emp, boss_emp, end_emp]
      end

    end

    describe 'a larger tree' do
      let(:org_hierarchy) { OrgHierarchy.new(employees) }
      let(:employees) { [bottom_emp, middle_emp, root_emp, end_emp] }
      let(:bottom_emp) { Employee.new(1, "start", 2) }
      let(:middle_emp) { Employee.new(2, "middle", 3) }
      let(:root_emp) { Employee.new(3, "root", nil) }
      let(:end_emp) { Employee.new(10, "end", 3) }

      it 'will return a route of uneven lengths' do
        planner = RoutePlanner.new(org_hierarchy)
        expect(planner.calculate_route(bottom_emp, end_emp)).to eq [bottom_emp, middle_emp, root_emp, end_emp]
      end
    end

  end
end
