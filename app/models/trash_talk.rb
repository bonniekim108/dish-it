class TrashTalk < ActiveRecord::Base
	belongs_to :battle
	belongs_to :user

	validates_presence_of :battle, :user, :trash

end
