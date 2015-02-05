FactoryGirl.define do

  factory :restaurant do
    name { Faker::Name.name }
    location { "#{Faker::Address.street_address}, #{Faker::Address.city} #{Faker::Address.zip}" }
    phone { Faker::PhoneNumber }
    yelp_rating_photo_url 'http://yelp.com/rating.jpg'
    yelp_photo_url 'http://yelp.com/photo.jpg'
    battle
  end

end