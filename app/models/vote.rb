class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant

	
  validates :user, presence: true 
  validates :restaurant, presence: true
 
end
