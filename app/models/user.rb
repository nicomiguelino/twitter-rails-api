class User < ApplicationRecord
  has_secure_password
  has_many :tweets, dependent: :destroy
  validates :username, uniqueness: true
  validates :email, uniqueness: true
end
