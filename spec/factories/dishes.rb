FactoryGirl.define do

  factory :dish do
    name { Faker::Lorem.word }
    cuisine "American"
    battle
  end

end