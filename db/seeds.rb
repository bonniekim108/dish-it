# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#--- Load counties table where Dish@It does business
County.create(name: 'Los Angeles', UTC_offset: -8)
County.create(name: 'Orange', UTC_offset: -8)

# #--- Load cuisine_lookups table
CuisineLookup.create(name: 'American')
CuisineLookup.create(name: 'Asian')
CuisineLookup.create(name: 'Italian')
CuisineLookup.create(name: 'Mexican')
CuisineLookup.create(name: 'Other')


# #--- Load users table
# 50.times do
#   user = User.create(
#     name: Faker::Name.name,
#     email: Faker::Internet.email,
#     password: 'abc-123',
#     password_confirmation: 'abc-123'
#   )
# end