class EmployeeFileParser

  def parse_employees file_name
    contents = File.read(file_name)
    parse_lines contents
  end

  private

  def parse_lines lines
    employees = []

    lines.each_line do |line|
      next if line =~ /Employee/
      parts = line.scan(/[^|]+/).map(&:strip)
      employees << create_employee_from_line(parts)
    end

    employees
  end

  def create_employee_from_line parts
    Employee.new(parts[0].to_i,
                 parts[1],
                 parse_manager_id(parts[2]))
  end

  def parse_manager_id manager_str
    return nil if manager_str.empty?
    manager_str.to_i
  end
end

#class ParseError < StandardError
#end
