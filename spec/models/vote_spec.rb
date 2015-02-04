require 'rails_helper'

RSpec.describe Vote, :type => :model do
  it "has a valid factory" do
    vote = build(:vote)
    expect(vote).to be_valid
  end
  it "is invalid without a user" do
    vote = build(:vote)
    vote.user = nil
    expect(vote).to be_invalid
  end
  it "is invalid without a restaurant" do
    vote = build(:vote)
    vote.restaurant = nil
    expect(vote).to be_invalid
  end
  it "is valid without a comment" do
    vote = build(:vote)
    vote.comment = nil
    expect(vote).to be_valid
  end
end
