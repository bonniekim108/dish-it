FactoryGirl.define do

  factory :vote do
    comment { Faker::Lorem.sentence }
    user { User.all.sample }
    # battle { Battle.new() }
  end

end