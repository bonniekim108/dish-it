class Dish < ActiveRecord::Base
  belongs_to :battle
  validates :cuisine, presence: true
  validates :name, presence: true
end
