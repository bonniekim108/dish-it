require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
  before(:each) do
    @restaurant = build(:restaurant)
  end
  it "has a valid factory" do
    expect(@restaurant).to be_valid
  end
  it "is invalid without a name" do
    @restaurant.name = nil
    expect(@restaurant).to be_invalid
  end
  it "is invalid without a location" do
    @restaurant.location = nil
    expect(@restaurant).to be_invalid
  end
  it "is invalid without a battle" do
    @restaurant.battle = nil
    expect(@restaurant).to be_invalid
  end
  it "is valid without a phone" do
    @restaurant.phone = nil
    expect(@restaurant).to be_valid
  end
  it "is valid without a yelp_rating_photo_url" do
    @restaurant.yelp_rating_photo_url = nil
    expect(@restaurant).to be_valid
  end
  it "is valid without a yelp_photo_url" do
    @restaurant.yelp_photo_url = nil
    expect(@restaurant).to be_valid
  end
end
