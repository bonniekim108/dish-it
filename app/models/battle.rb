class Battle < ActiveRecord::Base
  has_one :dish
  has_many :restaurants
  has_many :trash_talks

  def display_mode
  end

  validates :year_month, presence: true
  validates :dish, presence: true
end
