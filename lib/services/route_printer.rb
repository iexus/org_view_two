class RoutePrinter

  def print_route route
    route_string = ""
    route.each_cons(2) do |next_two|
      route_string += full_employee_name(next_two[0])
      route_string += direction_indicator(next_two)
    end
    route_string += full_employee_name(route.last)
  end

  private
  def full_employee_name employee
    "#{employee.name} (#{employee.id})"
  end

  def direction_indicator(next_two)
    next_two.first.manager_id == next_two.last.id ? " -> " : " <- "
  end
end
