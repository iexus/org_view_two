class Employee
  attr_reader :id
  attr_reader :name
  attr_reader :manager_id

  def initialize id, name, manager_id
    @id = id
    @name = name
    @manager_id = manager_id
  end
end
