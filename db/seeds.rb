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
20.times do |n|
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'abc123',
    password_confirmation: 'abc123',
    county: (n % 2) == 1 ? County.first : County.last
  )
  user.save
end
user = User.new(name: "Jim Clark", email: "email@jim-clark.com", password: "abc123", password_confirmation: "abc123")
user.county = County.first
user.save
user = User.new(name: "Edwin Alegre", email: "edwin@alegre.com", password: "abc123", password_confirmation: "abc123")
user.county = County.first
user.save
user = User.new(name: "Bonnie Kim", email: "bonniekim@example.com", password: "abc123", password_confirmation: "abc123")
user.county = County.first
user.save
user = User.new(name: "Ben Sam", email: "bensam123@hotstuff.com", password: "abc123", password_confirmation: "abc123")
user.county = County.first
user.save


