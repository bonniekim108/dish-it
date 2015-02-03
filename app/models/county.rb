class County < ActiveRecord::Base
  has_many :users
  validates_presence_of :name, :UTC_offset
end
