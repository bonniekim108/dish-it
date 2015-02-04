require 'rails_helper'

RSpec.describe PotentialDish, :type => :model do
  it 'has a valid factory' do
    pot_dish = build(:dish)
    expect(pot_dish).to be_valid
  end
end
