class PotentialDish < ActiveRecord::Base
  has_many :suggetions
	validates :name, presence: true
	validates :cuisine, presence: true
end
