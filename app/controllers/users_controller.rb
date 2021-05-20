class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = user_params
    user_email = user[:email].downcase
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:info] = "Welcome, #{new_user.email}!"
      redirect_to dashboard_index_path(user_email: "#{new_user.email}", user_id: "#{new_user.id}")
    else
      #add a few conditionals for sad path, i.e. email already exists, p-words weren't the same...etc
      flash[:error] = "Please make sure the passwords match"
      redirect_to "/register"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
