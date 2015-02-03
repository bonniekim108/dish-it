FactoryGirl.define do

  factory :restaurant do
    name { Faker::Name.name }
    location { Faker::Address.street_address + ', '
       + Faker::Address.city + ' ' + Faker::Address.zip }
    
    
  end

end