class Restaurant < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations

  validates :name, :address, :phone_number, :description, presence: true
  validates :number_of_tables, inclusion: 1..10
end
