require 'rails_helper'

RSpec.describe Vote, :type => :model do
  it "has a valid factory" do
    vote = build(:vote)
    expect(vote).to be_valid
  end
end
