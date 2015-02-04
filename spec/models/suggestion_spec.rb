require 'rails_helper'

RSpec.describe Suggestion, :type => :model do
  it 'has a valid factory' do
    sug = build(:suggestion)
    expect(sug).to be_valid
  end
end
