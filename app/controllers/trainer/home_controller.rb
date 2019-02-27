class Trainer::HomeController < ApplicationController
  before_action :logged_in_user
  before_action :trainer?

  def index
    @user_profile = current_user.user_profile
    render "shared/home"
  end
end
