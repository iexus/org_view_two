class OrgHierarchy
  def initialize employee_list
    @employees = {}
    employee_list.each { |employee| @employees[employee.id] = employee }
  end

  def manager_for employee
    @employees[employee.manager_id]
  end

  def employees_with_name name
    @employees.select { |id, employee| sanitize_name(employee.name) == sanitize_name(name) }.values
  end

  def employee_to_root employee
    managers = [employee]
    walk_tree(managers)
    managers
  end

  private
  def walk_tree employees_so_far
    return if employees_so_far.last.manager_id.nil?
    manager = manager_for(employees_so_far.last)
    raise HierarchyError if employees_so_far.include?(manager)
    employees_so_far << manager
    walk_tree(employees_so_far)
  end

  def sanitize_name name
    name.downcase.gsub(/\s+/, " ").strip
  end
end

class HierarchyError < StandardError; end
