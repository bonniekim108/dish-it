class Restaurant < ActiveRecord::Base
	belongs_to :battle
	has_many :votes
	has_many :users, through: :votes

  	validates :name, :location, :battle, presence: true
end
