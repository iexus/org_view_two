require 'services/route_planner'
require 'services/org_hierarchy'

class OrgChart
  def initialize file_parser
    @file_parser = file_parser
  end

  def find_path file_path, start_employee_name, end_employee_name
    employees = @file_parser.parse_employees(file_path)
    org_hierarchy = OrgHierarchy.new(employees)

    start_employee = org_hierarchy.employees_with_name(start_employee_name).first
    end_employee = org_hierarchy.employees_with_name(end_employee_name).first

    route = RoutePlanner.new(org_hierarchy).calculate_route(start_employee, end_employee)
    RoutePrinter.new.print_route(route)
  end
end
