FactoryGirl.define do

  factory :vote do
    comment { Faker::Lorem.sentence }
    user
    restaurant
  end

end