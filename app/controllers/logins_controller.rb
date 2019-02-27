class LoginsController < ApplicationController
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

  private

  def set_cookie_session user
    log_in user

    if params[:remember_me] == Settings.remember_me
      remember user
    else
      forget user
    end
    redirect_back_or root_path
  end
end
