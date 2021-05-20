class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && !current_user.admin?
  end

   helper_method :current_user, :current_admin?

   private

   def authorize
     unless User.find_by(id: session[:user_id])
       redirect_to root_path, notice: 'You do not have access to that page, please log in.'
    end
  end
end
