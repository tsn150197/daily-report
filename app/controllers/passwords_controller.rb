class PasswordsController < ApplicationController
  before_action :logged_in_user
  before_action :authentication
  before_action :compare_password
  before_action :check_nil_password

  def update
    @user = current_user
    respond_to do |format|
      if flash.count.zero?
        if @user.update password_params
          flash.now[:success] = t ".success"
        else
          flash.now[:danger] = t ".update_password_fail"
        end
      end
      format.js
    end
  end

  private

  def password_params
    params.require(:user).permit :password, :password_confirmation
  end

  def authentication
    return if current_user.authenticate(params[:user][:current_password])
    flash.now[:"danger 1"] = t ".wrong_old_password"
  end

  def compare_password
    return if params[:user][:password_current] != params[:user][:password]
    flash.now[:"danger 2"] = t ".duplicate_password"
  end

  def check_nil_password
    return if params[:user][:password].present?
    flash.now[:"danger 3"] = t ".password_nil"
  end
end
