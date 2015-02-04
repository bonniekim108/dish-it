require 'rails_helper'

RSpec.describe SuggestionBox, :type => :model do
  it 'has a valid factory' do
    sug_box = build(:suggestion_box)
    expect(sug_box).to be_valid
  end
  it "is valid without any suggestions" do
    sug_box = build(:suggestion_box_without_suggestions)
    expect(sug_box).to be_valid
  end
end
