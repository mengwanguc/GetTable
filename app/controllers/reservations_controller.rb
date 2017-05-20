class ReservationsController < ApplicationController
  def index
    @reservations = User.find_by(username: "mengwang").reservations.where(canceled: false)
  end

  def canceled
    @reservations = User.find_by(username: "mengwang").reservations.where(canceled: true)
  end

  # cancel a reservation
  def delete
    reservation = Reservation.find_by(id: params['id'])
    reservation.update(canceled: true)
    redirect_to "/reservations"
  end

  def create
    reservation = Reservation.new
    reservation.user_id = params["user_id"]
    reservation.restaurant_id = params["restaurant_id"]
    reservation.date = params["date"]
    reservation.time = params["time"]
    reservation.save
    redirect_to "/reservations"
  end

end
