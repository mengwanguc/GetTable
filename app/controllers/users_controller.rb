class UsersController < ApplicationController
  def create
    @user = User.new
    @user.first_name = params["first_name"]
    @user.last_name = params["last_name"]
    @user.username = params["username"]
    @user.password = params["password"]
    @user.email = params["email"]
    if @user.save
      flash[:success] = "Thanks for signing up"
      session["user_id"] = @user.id
      redirect_to "/"
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end


  def index
    if session["user_id"].blank?
      redirect_to "/login"
    else
      @user = User.find_by(id: session["user_id"])
      render "index"
    end
  end


  def edit
    if session["user_id"].blank?
      redirect_to "/login"
    else
      @user = User.find_by(id: session["user_id"])
      render "edit"
    end
  end


  def update
    if session["user_id"].blank?
      redirect_to "/login"
    else
      @user = User.find_by(id: session["user_id"])
      @user.password = params["password"]
      @user.email = params["email"]
      if @user.save
        flash[:success] = "information updated successfully"
        redirect_to "/users"
      else
        flash[:danger] = @user.errors.full_messages
        redirect_to "/users/edit"
      end
    end
  end

end
