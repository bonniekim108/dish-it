FactoryGirl.define do

  factory :battle do
    year_month { Date.new(2015, 2, -1) }

    transient do
      create_count 5
    end

    after(:build) do |bat, evaluator|
      bat.dish ||= build(:dish, :battle => bat)
      build_list(:restaurant, evaluator.create_count, battle: bat)
      build_list(:trash_talk, evaluator.create_count, battle: bat)
    end

  end

  factory :battle_without_restaurants_or_trash, parent: :battle do |b|
    year_month { Date.new(2015, 2, -1) }
    after(:build) do |bat, evaluator|
      bat.dish ||= build(:dish, :battle => bat)
    end
  end

end