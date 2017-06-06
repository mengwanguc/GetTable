class AdminsController < ApplicationController
  def stats
    if session["user_id"].blank?
      redirect_to "/login"
    else
      if User.find_by(id: session["user_id"]).is_admin == true
        render "stats"
      else
        flash[:danger] = "You are not admin!"
        redirect_to "/"
      end
    end

  end

end
