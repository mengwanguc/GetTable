class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find_by(id: params["id"])
    @reservations = @restaurant.reservations.where.not(review: nil)
  end

end
