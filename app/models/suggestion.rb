class Suggestion < ActiveRecord::Base
  belongs_to :suggestion_box
	belongs_to :user
	belongs_to :potential_dish
end
