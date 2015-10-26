class UsersController < ApplicationController
  def index
  end

  def new
  	@user = User.new
  	render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user.id)

    else
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :current_city, :email, :password, :image)
  end
end
