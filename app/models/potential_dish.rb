class PotentialDish < ActiveRecord::Base
	validates :name, presence: true
	validates :cuisine, presence: true
end
