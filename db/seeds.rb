# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a Site
current_site = Site.find_or_create_by(name: 'development') do |site|
	site.domain = 'development'
end

# Create an AdminUser
admin_user = AdminUser.find_or_create_by(username: 'Admin') do |admin|
	admin.password  = 'password'
	admin.firstname = 'first_name'
	admin.lastname  = 'last_name'
	admin.site_id   = current_site.id
end

# Create a Patient
User.find_or_create_by(username: 'User1') do |user|
	user.password  = 'password'
	user.firstname = 'user_fname'
	user.lastname  = 'user_lname'
	user.site_id   = current_site.id
end

puts "AdminUserUsername: 'Admin'"
puts "AdminUserPassword: 'password'"