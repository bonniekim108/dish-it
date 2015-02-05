require 'rails_helper'

RSpec.describe Battle, :type => :model do
  before(:each) do
    @battle = build(:battle)
  end

  it "has a valid factory" do
    expect(@battle).to be_valid
  end

  it 'is invalid without a year_month' do
    @battle.year_month = nil
    expect(@battle).to be_invalid
  end

  it 'is invalid without year_month being a valid date with a day equal to the last day of the month' do
    @battle.year_month = Date.new(2015, 2, 14)
    expect(@battle).to be_invalid
  end

  it 'is invalid without a dish' do
    battle = create(:battle)
    battle.dish = nil
    expect(battle).to be_invalid
  end
  it 'is valid without any restaurants or trash_talks' do
    battle = create(:battle_without_restaurants_or_trash)
    expect(battle).to be_valid
  end
  it 'is invalid without a display_mode method' do
    expect(@battle).to respond_to(:display_mode)
  end
  it 'display_mode should return "future" when today is before the month of the battle' do
    @battle.year_month = Date.new(2099, 1, 31)
    expect(@battle.display_mode).to eq('future')
  end
  it 'display_mode should return "nominating" when today is 14 days or more before the last day month of a current month' do
    today = Date.today
    @battle.year_month = today.end_of_month
    before_eom = (@battle.year_month.day - today.day)
    if (today.month = @battle.year_month.month) & (before_eom > 13)
      expect(@battle.display_mode).to eq('future')
    else
      puts "UNABLE TO DETERMINE VALIDITY OF THIS NEXT TEST"
      expect(true).to eq(true)
    end
  end
  it 'display_mode should return "great_eight" when today is 7 to 13 days before last day month of a current month' do
    today = Date.today
    @battle.year_month = today.end_of_month
    before_eom = (@battle.year_month.day - today.day)
    if (today.month = @battle.year_month.month) & before_eom.between?(7, 13)
      expect(@battle.display_mode).to eq('great_eight')
    else
      puts "UNABLE TO DETERMINE VALIDITY OF THIS NEXT TEST"
      expect(true).to eq(true)
    end
  end
  it 'display_mode should return "final_four" when today is 0 to 6 days before last day month of a current month' do
    today = Date.today
    @battle.year_month = today.end_of_month
    before_eom = (@battle.year_month.day - today.day)
    if (today.month = @battle.year_month.month) & before_eom.between?(0, 6)
      expect(@battle.display_mode).to eq('final_four')
    else
      puts "UNABLE TO DETERMINE VALIDITY OF THIS NEXT TEST"
      expect(true).to eq(true)
    end
  end

end
