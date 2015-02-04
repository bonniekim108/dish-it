FactoryGirl.define do

  factory :county do
    name 'Los Angeles'
    UTC_offset -8

    transient do
      users_count 5
    end

    after(:create) do |cnty, evaluator|
      create_list(:user, evaluator.users_count, county: cnty)
    end

  end

end