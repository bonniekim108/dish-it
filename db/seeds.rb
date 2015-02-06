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

#--- Load cuisine_lookups table
CuisineLookup.create(name: 'American')
CuisineLookup.create(name: 'Asian')
CuisineLookup.create(name: 'Italian')
CuisineLookup.create(name: 'Mexican')
CuisineLookup.create(name: 'Other')


#--- Load users table
200.times do |n|
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

users = User.all.to_a  # for use later


#--- load potential_dishes
PotentialDish.create(name: 'Korean BBQ - All You Can Eat', cuisine: 'Asian')
PotentialDish.create(name: 'BBQ Ribs', cuisine: 'American')
PotentialDish.create(name: 'Hamburger - Bacon Cheese', cuisine: 'American')
PotentialDish.create(name: 'Hamburger - Classic', cuisine: 'American')
PotentialDish.create(name: 'Carne Asada Burrito', cuisine: 'Mexican')
PotentialDish.create(name: 'Deep Dish Pizza', cuisine: 'Italian')
PotentialDish.create(name: 'Soup - Chicken Noodle', cuisine: 'American')
PotentialDish.create(name: 'Chicken Tandoori', cuisine: 'Indian')
PotentialDish.create(name: 'Chili Cheese Fries', cuisine: 'American')
PotentialDish.create(name: 'Chow Mein', cuisine: 'Chinese')
PotentialDish.create(name: 'Soup - Clam Chowder', cuisine: 'American')
PotentialDish.create(name: 'Crab Cakes', cuisine: 'American')
PotentialDish.create(name: 'Crepes (savory)', cuisine: 'American')
PotentialDish.create(name: 'Cupcakes', cuisine: 'American')
PotentialDish.create(name: 'Fettucine Alfredo', cuisine: 'Italian')
PotentialDish.create(name: 'Steak - Filet Mignon', cuisine: 'American')
PotentialDish.create(name: 'Fish Tacos', cuisine: 'Mexican')
PotentialDish.create(name: 'Fried Chicken', cuisine: 'American')
PotentialDish.create(name: 'Japanese Curry', cuisine: 'Asian')
PotentialDish.create(name: 'Kung Pao Chicken', cuisine: 'Chinese')
PotentialDish.create(name: 'Lasagna', cuisine: 'Italian')
PotentialDish.create(name: 'Macaroni and Cheese', cuisine: 'American')
PotentialDish.create(name: 'Nachos', cuisine: 'Mexican')
PotentialDish.create(name: 'Pad Thai', cuisine: 'Asian')
PotentialDish.create(name: 'Sandwich - Pastrami', cuisine: 'American')
PotentialDish.create(name: 'Sandwich - Philadelphia Cheese Steak', cuisine: 'American')
PotentialDish.create(name: 'Pho', cuisine: 'Asian')
PotentialDish.create(name: 'Ramen', cuisine: 'Japanese')
PotentialDish.create(name: 'Shabu Shabu', cuisine: 'Asian')
PotentialDish.create(name: 'Spaghetti and Meatballs', cuisine: 'Italian')
PotentialDish.create(name: 'Spring Rolls', cuisine: 'Asian')
PotentialDish.create(name: 'Sushi', cuisine: 'Asian')

pot = PotentialDish.all.to_a  # for use later

#--- Load suggestions

300.times do
  sug = Suggestion.create(potential_dish: pot.sample, user: users.sample)
end


#--- Previous battles

4.times do |n|
  battleDate = (n + 1).months.ago.end_of_month
  b = Battle.new(year_month: battleDate)
  p = pot.sample
  b.dish = Dish.new(name: p.name, cuisine: p.cuisine)
  if n != 1  # two battles ago will not have any restaurants or trash_talks for testing purposes
    num_rests = rand(1..50)
    num_rests.times do
      r = Restaurant.new(name: Faker::App.name, location: Faker::Address.city, phone: Faker::PhoneNumber.phone_number)
      numVotes = rand(1..20)
      usersVoted = []
      numVotes.times do
        v = Vote.new()
        hasComment = [true, false].sample
        v.comment = Faker::Lorem.sentence if hasComment
        u = users.sample
        until !usersVoted.include?(u.id)
          u = users.sample
        end
        usersVoted << u.id
        v.user = u
        r.votes << v
      end
      b.restaurants << r
    end
    num_trash = rand(1..5)
    num_trash.times do
      t = TrashTalk.new(trash: Faker::Lorem.sentence, user: users.sample)
      b.trash_talks << t
    end
  end
  b.save
end


#--- Current month's battle

battleDate = Date.today.end_of_month
b = Battle.new(year_month: battleDate)
p = pot.sample
b.dish = Dish.new(name: p.name, cuisine: p.cuisine)
  num_rests = rand(1..20)
  num_rests.times do
    r = Restaurant.new(name: Faker::App.name, location: Faker::Address.city, phone: Faker::PhoneNumber.phone_number)
    numVotes = rand(1..15)
    usersVoted = []
    numVotes.times do
      v = Vote.new()
      hasComment = [true, false].sample
      v.comment = Faker::Lorem.sentence if hasComment
      u = users.sample
      until !usersVoted.include?(u.id)
        u = users.sample
      end
      usersVoted << u.id
      v.user = u
      r.votes << v
    end
    b.restaurants << r
  end
  num_trash = rand(1..5)
  num_trash.times do
    t = TrashTalk.new(trash: Faker::Lorem.sentence, user: users.sample)
    b.trash_talks << t
  end
b.save


