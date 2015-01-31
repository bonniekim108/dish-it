class User < ActiveRecord::Base
  has_secure_password
  has_one :county
  validates :password, length: { minimum: 4 }, allow_nil: true
  validates :password, confirmation: true
  validates :name, :email, presence: true

end
