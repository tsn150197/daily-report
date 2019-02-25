class Admin::HomeController < ApplicationController
  def index
    user = Admin.first
    session[:user_id] = user.id
    @user_profile = user.user_profile
    render "shared/home"
  end
end
