require 'spec_helper'
require 'services/employee_file_parser'
require 'employee'

describe EmployeeFileParser do
  describe '#parse_employees' do
    let(:dangermouse) { Employee.new(1, "Dangermouse", 2) }

    describe 'a header line present' do
      let(:file_contents) { "| Employee ID | Name            | Manager ID |\n" +
                            "| #{dangermouse.id}           | #{dangermouse.name} | #{dangermouse.manager_id}          |\n" }

      it 'will ignore the header line if present' do
        allow(File).to receive(:read).and_return(file_contents)
        expect(subject.parse_employees("a_file")[0]).to equal_employee(dangermouse)
      end
    end

    describe 'a single employee line' do
      let(:file_name) { "a_file" }
      let(:file_contents) { "| #{dangermouse.id}           | #{dangermouse.name} | #{dangermouse.manager_id}          |" }

      it 'will parse a line of the file into an employee' do
        allow(File).to receive(:read).with(file_name).and_return(file_contents)
        expect(subject.parse_employees(file_name)[0]).to equal_employee(dangermouse)
      end
    end

    describe 'an employee who has no manager_id' do
      let(:file_contents) { "| #{dangermouse.id}           | #{dangermouse.name} |          |" }

      it 'will return an employee with a nil manager_id' do
        allow(File).to receive(:read).and_return(file_contents)
        employee = subject.parse_employees("a_file")[0]
        expect(employee.manager_id).to be_nil
      end
    end

    describe 'multiple employees in one file' do
      let(:invisible_woman) { Employee.new(3, "Invisible woman", 1) }
      let(:black_widow)     { Employee.new(6, "Black Widow", 2) }
      let(:file_contents) { "| #{invisible_woman.id}           | #{invisible_woman.name} | #{invisible_woman.manager_id}          |\n" +
                            "| #{black_widow.id}           | #{black_widow.name}     | #{black_widow.manager_id}          |\n" }

      it 'will return all employees who are in the file' do
        allow(File).to receive(:read).and_return(file_contents)
        employees = subject.parse_employees("a_file")
        expect(employees.count).to eq 2
        expect(employees[0]).to equal_employee(invisible_woman)
        expect(employees[1]).to equal_employee(black_widow)
      end
    end
  end
end
