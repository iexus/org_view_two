require 'spec_helper'

describe OrgHierarchy do

  describe '#employees_with_name' do

    let(:danger_mouse) { Employee.new(1, "Danger mouse", 10) }
    let(:spartacus_1) { Employee.new(2, "spartacus", 10) }
    let(:spartacus_2) { Employee.new(3, "spartacus", 10) }

    subject { OrgHierarchy.new([danger_mouse, spartacus_1, spartacus_2]) }

    it 'will return an employee with the given name' do
      expect(subject.employees_with_name('Danger mouse')).to eq [danger_mouse]
    end

    it 'will return multiple employees if they both have the same name' do
      expect(subject.employees_with_name('spartacus')).to eq [spartacus_1, spartacus_2]
    end

    it 'will match an employee by name regardless of case' do
      expect(subject.employees_with_name('DANGER MOUSE')).to eq [danger_mouse]
    end

    it 'will match an employee by name regardless of white space' do
      expect(subject.employees_with_name('DANGER   MOUSE   ')).to eq [danger_mouse]
    end

  end

  describe '#manager_for' do
    let(:batman) { Employee.new(1, "Batman", 10) }
    let(:danger_mouse) { Employee.new(10, "Danger Mouse", nil) }
    let(:employee_list) { [batman, danger_mouse] }

    subject { OrgHierarchy.new(employee_list) }

    it 'will return the boss of an employee' do
      expect(subject.manager_for(batman)).to eq danger_mouse
    end

    it 'will return nil if the employee is a root boss' do
      expect(subject.manager_for(danger_mouse)).to be_nil
    end
  end

  describe '#employee_to_root' do
    let(:batman) { Employee.new(1, "Batman", 2) }
    let(:cat_woman) { Employee.new(2, "Cat Woman", 3) }
    let(:super_ted) { Employee.new(3, "Super Ted", 10) }
    let(:danger_mouse) { Employee.new(10, "Danger Mouse", nil) }
    let(:employee_list) { [danger_mouse, cat_woman, super_ted, batman] }

    subject { OrgHierarchy.new(employee_list) }

    context 'a normal hierarchy' do
      it 'will return the whole chain up to the root employee' do
        expect(subject.employee_to_root(batman)).to eq [batman, cat_woman, super_ted, danger_mouse]
      end
    end

    context 'when their is a cycle in the tree' do
      let(:batman) { Employee.new(1, "Batman", 2) }
      let(:catwoman) { Employee.new(2, "Catwoman", 3) }
      let(:danger_mouse) { Employee.new(3, "Danger mouse", 1) }
      let(:employee_list) { [batman, catwoman, danger_mouse] }

      subject { OrgHierarchy.new(employee_list) }

      it 'will check for loops in the employee tree' do
        expect { subject.employee_to_root(batman) }.to raise_error HierarchyError
      end
    end
  end
end
