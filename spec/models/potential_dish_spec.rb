require 'rails_helper'

RSpec.describe PotentialDish, :type => :model do
  it 'has a valid factory' do
    pot_dish = build(:potential_dish)
    expect(pot_dish).to be_valid
  end

  it 'is invalid without a name' do
    pot_dish = build(:potential_dish)
    pot_dish.name = nil
    expect(pot_dish).to be_invalid
  end

  it 'is invalid without a cuisine' do
    pot_dish = build(:potential_dish)
    pot_dish.cuisine = nil
    expect(pot_dish).to be_invalid
  end

end
