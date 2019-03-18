class PasswordResetsController < ApplicationController
  before_action :find_user, only: %i(create edit update)
  before_action :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t ".send_email_user"
    redirect_to root_url
  end

  def edit; end

  def update
    if params[:user][:password].present? && @user.update(user_params)
      log_in @user
      @user.update reset_digest: nil
      flash[:success] = t ".reset_success"
      redirect_to send("#{@user.type.downcase}_root_path")
    else
      handle_reset_fail @user
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    return if @user = User.find_by(email: params[:email].downcase)
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_path
  end

  def valid_user
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])
    flash[:danger] = t ".user_not_valid"
    redirect_back fallback_location: root_path
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t ".expired_warning"
    redirect_to new_password_reset_url
  end

  def handle_reset_fail user
    if params[:user][:password].empty?
      user.errors.add :password, t(".email_empty")
    else
      flash.now[:danger] = t ".not_reset_password"
    end
    render :edit
  end
end
