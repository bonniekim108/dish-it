FactoryGirl.define do

  factory :battle do
    year_month { Date.new(2015, 2, -1) }

    transient do
      restaurants_count 5
    end

    after(:create) do |bat, evaluator|
      create_list(:restaurant, evaluator.restaurants_count, battle: bat)
    end

  end

end