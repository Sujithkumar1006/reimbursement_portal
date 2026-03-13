# db/seeds.rb

puts "Clearing old data..."

Bill.delete_all
Employee.delete_all
Department.delete_all
User.delete_all

puts "Creating departments..."

departments = [
  Department.create!(name: "Software Engineering"),
  Department.create!(name: "Finance"),
  Department.create!(name: "Human Resources"),
  Department.create!(name: "Operations"),
  Department.create!(name: "Customer Success"),
  Department.create!(name: "Quality Assurance")

]

puts "Creating admin user..."

User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@portal.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

employee_data = [
  [ "John", "Doe", "john.doe@business.com", "Software Engineer" ],
  [ "Jane", "Smith", "jane.smith@business.com", "QA Engineer" ],
  [ " Michael", "Brown", "michael.brown@business.com", "Backend Developer" ]
]

puts "Creating employee users and employee profiles..."

employee_data.each_with_index.map do |(first_name, last_name, email, designation), index|
  user = User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: "password123",
    password_confirmation: "password123",
    role: :employee
  )

  Employee.create!(
    user: user,
    designation: designation,
    department: departments[index % departments.length]
  )
end

puts "Seeding completed successfully!"
puts "Admin login: admin@portal.com / password123"
puts "Employee login example: john.doe@business.com / password123"
