class Dish < ActiveRecord::Base
  belongs_to :battle
  validates :cuisine, presence: true
end
