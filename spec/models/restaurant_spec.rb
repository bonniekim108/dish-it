require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
  it 'has a valid factory' do
    rest = build(:restaurant)
    expect(rest).to be_valid
  end
end
