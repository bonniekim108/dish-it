FactoryGirl.define do

  factory :trash_talk do
    trash { Faker::Lorem.sentence }
    user
    battle
  end

end