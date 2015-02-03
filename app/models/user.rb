class User < ActiveRecord::Base
  
  has_secure_password
  has_one :county
  has_many :votes
  has_many :restaurants, through: :votes
  
  validates :password, length: { minimum: 4 }, allow_nil: true
  validates :password, confirmation: true
  validates :name, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :county, presence: true

  def is_admin?
    is_admin: false
  end
end

