class User < ActiveRecord::Base
  has_secure_password
  has_one :county
  has_many :votes
  has_many :restaurants, through: :votes
  
  validates :password, length: { minimum: 4 }, allow_nil: true
  validates :password, confirmation: true
  validates :name, :email, presence: true

end
