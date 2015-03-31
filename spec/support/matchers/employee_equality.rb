RSpec::Matchers.define :equal_employee do |expected|
  match do |actual|
    actual.id == expected.id &&
    actual.name == expected.name &&
    actual.manager_id == expected.manager_id
  end
end
