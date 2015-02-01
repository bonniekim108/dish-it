class Battle < ActiveRecord::Base
  has_one :dish
  has_many :restaurants
  has_many :trash_talks
end