require 'rails_helper'

RSpec.describe Battle, :type => :model do
  
  it 'is invalid without a year_month'
  it 'is invalid without year_month being a valid date'
  it 'is invalid without year_month being a valid date with a day equal to the last day of the month'
  it 'is invalid without a dish'
  it 'is valid without any restaurants'
  it 'is valid without any trash_talks'
  it 'is invalid without a mode method'
  it 'is invalid unless the mode method returns the mode as a valid mode_enum'
  it 'is invalid unless the mode method returns the appropriate mode according to the day of the month'

end
