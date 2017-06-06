class User < ApplicationRecord
  has_secure_password

  has_many :reservations
  has_many :restaurants, through: :reservations

  validates :username, :password, :email, :first_name, :last_name, presence: true
  validates :username, uniqueness: true
end
