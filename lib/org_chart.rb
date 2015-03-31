require_relative 'services/org_hierarchy'
require_relative 'services/route_planner'

class OrgChart
  def initialize file_parser
    @file_parser = file_parser
  end

  def find_path file_path, start_employee_name, end_employee_name
    employees = @file_parser.parse_employees(file_path)
    org_hierarchy = OrgHierarchy.new(employees)

    start_employee = org_hierarchy.employees_with_name(start_employee_name).first
    end_employee = org_hierarchy.employees_with_name(end_employee_name).first
    raise OrgChartError.new("Could not find an employee in organisation: #{start_employee_name}, #{end_employee_name}") if start_employee.nil? || end_employee.nil?

    route = RoutePlanner.new(org_hierarchy).calculate_route(start_employee, end_employee)
    RoutePrinter.new.print_route(route)
  end
end

class OrgChartError < StandardError; end
