class TrashTalk < ActiveRecord::Base
	belongs_to :battle
	belongs_to :user
end
