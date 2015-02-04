FactoryGirl.define do

  factory :battle do
    year_month { Date.new(2015, 2, -1) }

    transient do
      create_count 5
    end

    after(:create) do |bat, evaluator|
      bat.dish ||= build(:dish, :battle => bat)
      create_list(:restaurant, evaluator.create_count, battle: bat)
      create_list(:trash_talk, evaluator.create_count, battle: bat)
    end

  end

  factory :battle_without_restaurants_or_trash, parent: :battle do
    year_month { Date.new(2015, 2, -1) }
  end

end