class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged out!"
  end
end
