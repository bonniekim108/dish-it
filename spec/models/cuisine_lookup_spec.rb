require 'rails_helper'

RSpec.describe CuisineLookup, :type => :model do
  it 'has a valid factory' do
    cuisine = build(:cuisine_lookup)
  end
  it 'is invalid without a name' do
    cuisine = build(:cuisine_lookup, name: nil)
    expect(cuisine).to be_invalid
  end
end
