class DashboardController < ApplicationController
  def index
    @user = current_user
    @hosting_party = @user.parties
    @watching_party = @user.invites
  end

  def create
    if params.include?(:friend_search)
      user = current_user
      friend = params[:friend_search]
      if User.find_by(email: "#{friend}").nil?
        flash[:error] = "#{friend} is not currently active with Viewing Party."
        redirect_to dashboard_index_path
      else
        search = User.find_by(email: "#{friend}")
        UserFriend.create(user_id: user.id, friend_id: search.id) if search.id != current_user.id
        redirect_to dashboard_index_path
      end
    end
  end
end
