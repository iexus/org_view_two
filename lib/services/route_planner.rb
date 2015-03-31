class RoutePlanner

  def initialize org_hierarchy
    @org_hierarchy = org_hierarchy
  end

  def calculate_route start_employee, end_employee
    start_to_root = @org_hierarchy.employee_to_root start_employee
    end_to_root = @org_hierarchy.employee_to_root end_employee

    common_node = find_common_node(start_to_root, end_to_root)
    path_to_and_from(common_node, start_to_root, end_to_root)
  end

  private
  def find_common_node start_list, end_list
    start_list.each do |employer|
      return employer if end_list.include?(employer)
    end
  end

  def path_to_and_from(common_node, start_route, end_route)
    start_to_common = path_to_node(start_route, common_node)
    start_to_common << common_node
    end_to_common = path_to_node(end_route, common_node)

    start_to_common + end_to_common.reverse
  end

  def path_to_node(route, common_node)
    route[0...route.index(common_node)]
  end
end
