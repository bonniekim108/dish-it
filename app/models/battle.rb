class Battle < ActiveRecord::Base
  has_one :dish
  has_many :restaurants
  has_many :trash_talks

  validates :year_month, presence: true
  validates :dish, presence: true
  validate :is_eom
  validate :display_mode

  def is_eom
  	if self.year_month
      eom = Date.new(self.year_month.year, self.year_month.month, -1)
      if eom != self.year_month
        errors.add(:year_month, "must be end of month")
      end
    end
  end

  def display_mode
    if self.year_month
      countdown = (self.year_month.day - Date.today.day)
      if Date.today.year < self.year_month.year || (Date.today.year == self.year_month.year && Date.today.month < self.year_month.month)
        "future"
      elsif countdown > 13
        "nominating"
      elsif countdown <= 13 && countdown > 6
        "great_eight"
      elsif countdown >= 0
        "final_four"
      else
        "winner"
      end
    end
  end

end