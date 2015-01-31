class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant

	validates :comment, presence: true 
end
