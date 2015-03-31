#!/usr/bin/env ruby

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

if ARGV.count != 3
  puts "usage: ruby start.rb <filename> <employee 1> <employee 2>"
  return
end

file_name, start_employee, end_employee = ARGV

org_chart = OrgChart.new(EmployeeFileParser.new)
route = org_chart.find_path(file_name, start_employee, end_employee)
puts route
