FactoryGirl.define do

  factory :dish do
    name { Faker::Lorem.word }
    cuisine { CuisineLookup.first }
    # battle { Battle.new() }
  end

end