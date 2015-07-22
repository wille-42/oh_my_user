puts 'Creating admin staff...'
role = Role.find_or_create_by(name: 'admin')
staff = Staff.create_with(password: 'ohmyuser').find_or_create_by(name: 'ohmyuser')
staff.add_role(role)

puts 'Done!'
