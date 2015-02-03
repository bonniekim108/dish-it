FactoryGirl.define do

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'abc-123'
    password_confirmation 'abc-123'
    county County.first
  end

end