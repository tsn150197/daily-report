class Admin::HomeController < ApplicationController
  before_action :logged_in_user
  before_action :admin?

  def index
    @user_profile = current_user.user_profile
    render "shared/home"
  end
end
