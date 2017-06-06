class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find_by(id: params["id"])
    @reservations = @restaurant.reservations.where.not(review: nil)
  end

  def edit
    @restaurant = Restaurant.find_by(id: params["id"])
  end

  def update
    @restaurant = Restaurant.find_by(id: params["id"])
    @restaurant.name = params["name"]
    @restaurant.city = params["city"]
    @restaurant.address = params["address"]
    @restaurant.cuisines = params["cuisines"]
    @restaurant.dining_style = params["dining_style"]
    @restaurant.price_range = params["price_range"]
    @restaurant.phone_number = params["phone_number"]
    @restaurant.website = params["website"]
    @restaurant.description = params["description"]
    @restaurant.photo_url = params["photo_url"]
    @restaurant.number_of_tables = params["number_of_tables"]
    if @restaurant.save
      flash[:success] = "Successfully updated!"
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      flash[:danger] = @restaurant.errors.full_messages
      redirect_to "/restaurants/#{@restaurant.id}/edit"
    end
  end


  def new
    if session["user_id"].blank?
      redirect_to "/login"
    else
      @user = User.find_by(id: session["user_id"])
      if @user.is_admin == true
        render "new"
      else
        flash[:danger] = "You are not admin!"
        redirect_to "/"
      end
    end
  end


  def create
    @restaurant = Restaurant.new
    @restaurant.name = params["name"]
    @restaurant.city = params["city"]
    @restaurant.address = params["address"]
    @restaurant.cuisines = params["cuisines"]
    @restaurant.dining_style = params["dining_style"]
    @restaurant.price_range = params["price_range"]
    @restaurant.phone_number = params["phone_number"]
    @restaurant.website = params["website"]
    @restaurant.description = params["description"]
    @restaurant.photo_url = params["photo_url"]
    @restaurant.number_of_tables = params["number_of_tables"]
    if @restaurant.save
      flash[:success] = "Successfully added!"
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      flash[:danger] = @restaurant.errors.full_messages
      redirect_to "/restaurants/new"
    end
  end


  def destroy
    @restaurant = Restaurant.find_by(id: params["id"])
    # delete the corresponding reservations first
    reservations = Reservation.where(restaurant_id: @restaurant.id)
    reservations.each do |reservation|
      reservation.delete
    end

    if @restaurant.delete
      flash[:success] = "Successfully deleted!"
      redirect_to "/restaurants"
    else
      flash[:danger] = @restaurant.errors.full_messages
      redirect_to "/restaurants"
    end
  end

  def show_reservations
    @restaurant = Restaurant.find_by(id: params["id"])
    @reservations = @restaurant.reservations.order('date desc, time desc')
  end
end
