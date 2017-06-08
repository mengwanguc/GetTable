class ReservationsController < ApplicationController
  def index
    if session["user_id"].blank?
      redirect_to "/login"
    else
      @user = User.find_by(id: session["user_id"])
      @reservations = User.find_by(username: @user.username).reservations.where(canceled: false).order('date desc, time desc')
    end
  end

  def canceled
    if session["user_id"].blank?
      redirect_to "/login"
    else
      @user = User.find_by(id: session["user_id"])
      @reservations = User.find_by(username: @user.username).reservations.where(canceled: true).order('date desc, time desc')
    end
  end

  # cancel a reservation
  def destroy
    reservation = Reservation.find_by(id: params['id'])
    reservation.update(canceled: true)
    user = User.find_by(id: session["user_id"])
    user.update(points: user.points - 10 * reservation.tables.to_i)
    redirect_to "/reservations"
  end

  # create a new reservation
  def create
    if session["user_id"].blank?
      redirect_to "/login"
    else
      # we request that the reservation date must be some day after today
      if params["date"] <= Date.today.to_s
        flash[:danger] = "You can only reserve for a date later than today!"
        redirect_to "/restaurants/#{params["restaurant_id"]}"
      else
        # check whether there are enough tables left
        conflict_reservations = Reservation.where(canceled: false).where(date: params["date"], time: params["time"])
        left_tables = Restaurant.find_by(id: params["restaurant_id"]).number_of_tables
        conflict_reservations.each do |r|
          left_tables = left_tables - r.tables
        end

        # if not enough tables
        if left_tables < params["tables"].to_i
          flash[:danger] = "There are #{left_tables} tables left at that time!"
          redirect_to "/restaurants/#{params["restaurant_id"]}"
        # if enough tables
        else
          # save the reservation record
          reservation = Reservation.new
          reservation.user_id = session["user_id"]
          reservation.restaurant_id = params["restaurant_id"]
          reservation.date = params["date"]
          reservation.time = params["time"]
          reservation.tables = params["tables"]
          reservation.save
          # user gain points
          user = User.find_by(id: session["user_id"])
          user.update(points: user.points + 10 * params["tables"].to_i)
          redirect_to "/reservations"
        end
      end
    end
  end

  # write a review for a reservation
  def new_review
    @reservation = Reservation.find_by(id: params["id"])
    @restaurant = Restaurant.find_by(id: @reservation.restaurant_id)
    if session["user_id"].blank?
      redirect_to "/login"
    elsif @reservation.user_id != session["user_id"]
      flash[:danger] = "This reservation does not belong to you!"
      redirect_to "/reservations"
    else
      render 'new_review'
    end
  end


  # create a review for a reservation
  def create_review
    @reservation = Reservation.find_by(id: params["id"])
    @reservation.review = params["review"]
    @reservation.save
    redirect_to "/restaurants/#{@reservation.restaurant_id}"
  end


  # show all reservations
  def show_all
    if session["user_id"].blank?
      redirect_to "/login"
    else
      if User.find_by(id: session["user_id"]).is_admin == true
        @reservations = Reservation.all.order('restaurant_id asc, date desc, time desc')
        render "show_all"
      else
        flash[:danger] = "You are not admin!"
        redirect_to "/"
      end
    end
  end

end
