class ActivateAccountsController < ApplicationController
  def edit; end

  def update
    if validate_user?
      @user.update password: params[:password], activated: true,
        activated_at: Time.zone.now
      flash[:success] = t ".success"
      redirect_to new_user_profile_path(@user)
    else
      handle_fail_activate
    end
  end

  private

  def validate_user?
    @user = User.find_by id: params[:id]

    if @user&.authenticate(params[:password_current]) && !@user.activated? &&
       (params[:password_current] != params[:password])
      true
    else
      false
    end
  end

  def handle_fail_activate
    if params[:password_current] == params[:password]
      flash.now[:warning] = t ".warning"
    else
      flash.now[:danger] = t ".danger"
    end
    render :edit
  end
end
