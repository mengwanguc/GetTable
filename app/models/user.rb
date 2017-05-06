class User < ApplicationRecord
  has_many :reservations
  has_many :restaurants, through: :reservations

  validates :username, :password, :email, :first_name, :last_name, presence: true

end
