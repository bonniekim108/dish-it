class Suggestion < ActiveRecord::Base
	belongs_to :user
	has_one :potential_dish
end
