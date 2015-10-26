class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      # login user
      session[:user_id] = user.id
      # go to profile page
      redirect_to user_path(user)
    else
      # handle error
      redirect_to login_path
    end
  end

  def destroy
    # logout
    session[:user_id] = nil
    redirect_to root_path
  end

end
