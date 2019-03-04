class LoginsController < ApplicationController
  before_action :redirect_logged_in, only: %i(new)
  def new; end

  def create
    user = User.find_by email: params[:email].downcase

    if user&.authenticate(params[:password])
      set_cookie_session user
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def set_cookie_session user
    if user.activated? && user.user_profile
      set_success user
    elsif !user.activated?
      flash[:warning] = t ".warning_activate"
      redirect_to activate_path(user)
    else
      flash[:warning] = t ".warning_profile"
      redirect_to new_user_profile_path(user)
    end
  end

  def set_success user
    log_in user

    if params[:remember_me] == Settings.remember_me
      remember user
    else
      forget user
    end
    redirect_back_or send("#{current_user.type.downcase}_root_path")
  end

  def redirect_logged_in
    return unless session[:user_id] || cookies.signed[:user_id]
    user = User.find_by id: session[:user_id] || cookies.signed[:user_id]
    redirect_to send("#{user.type.downcase}_root_path")
  end
end
