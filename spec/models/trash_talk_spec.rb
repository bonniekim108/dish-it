require 'rails_helper'

RSpec.describe TrashTalk, :type => :model do
  it 'has a valid factory' do
    trash = build(:trash_talk)
    expect(trash).to be_valid
  end
  it "is invalid without trash content" do
    trash = build(:trash_talk)
    trash.trash = nil
    expect(trash).to be_invalid
  end
  it "is invalid without a user" do
    trash = build(:trash_talk)
    trash.user = nil
    expect(trash).to be_invalid
  end
  it "is invalid without a battle" do
    trash = build(:trash_talk)
    trash.battle = nil
    expect(trash).to be_invalid
  end
end
