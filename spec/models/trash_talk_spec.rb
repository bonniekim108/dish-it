require 'rails_helper'

RSpec.describe TrashTalk, :type => :model do
  it 'has a valid factory' do
    trash = build(:trash_talk)
    expect(trash).to be_valid
  end
end
