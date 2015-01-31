class Restaurant < ActiveRecord::Base
	belongs_to :battle
	has_many :votes
end
