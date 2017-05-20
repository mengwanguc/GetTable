class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :restaurant_id, presence: true, numericality: { only_integer: true }
  validates :date, :time, presence: true

  validate :validate_user_id
  validate :validate_restaurant_id

private

 def validate_user_id
   errors.add(:user_id, "is invalid") unless User.exists?(id: self.user_id)
 end

 def validate_restaurant_id
   errors.add(:restaurant_id, "is invalid") unless Restaurant.exists?(id: self.restaurant_id)
 end


end
