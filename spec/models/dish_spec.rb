require 'rails_helper'

RSpec.describe Dish, :type => :model do

  it 'has a valid factory' do
    dish = build(:dish)
  end

  it 'is invalid without a name' do
    dish = build(:dish, name: nil)
    expect(dish).to be_invalid
  end

  it 'is invalid without a cuisine' do
    dish = build(:dish, cuisine: nil)
    expect(dish).to be_invalid
  end

end
