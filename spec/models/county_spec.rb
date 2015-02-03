require 'rails_helper'

RSpec.describe County, :type => :model do

  it 'has a valid factory' do
    county = build(:county)
    expect(county).to be_valid
  end

  it 'is invalid without a name' do
    county = build(:county)
    county.name = nil
    expect(county).to be_invalid
  end

  it 'is invalid without a UTC_offset' do
    county = build(:county)
    county.UTC_offset = nil
    expect(county).to be_invalid
  end

end