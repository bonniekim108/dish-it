FactoryGirl.define do

  factory :suggestion_box do
    transient do
      suggestions_count 5
    end
    after(:create) do |sug_box, evaluator|
      create_list(:suggestion, evaluator.suggestions_count, suggestion_box: sug_box)
    end
  end

end