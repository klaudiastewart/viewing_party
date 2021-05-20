class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_index_path(user_email: "#{user.email}")
    else
      flash[:error] = "Sorry, your credentials are bad."
      render root_path
    end
  end

  def destroy
    session.delete :user_id
    flash[:message] = 'You have been logged out.'
    redirect_to root_path
  end
end
