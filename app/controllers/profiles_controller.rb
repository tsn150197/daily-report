class ProfilesController < ApplicationController
  before_action :find_user, only: %i(new create)
  before_action :find_profile, only: %i(edit update)

  def new
    @profile = @user.build_user_profile
  end

  def create
    @profile = @user.build_user_profile profile_params

    if @profile.save && @user.authenticate(params[:user_profile][:password])
      log_in @user
      flash[:success] = t ".success"
      redirect_to send("#{@user.type.downcase}_root_path")
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @profile.update profile_params
    flash[:success] = t ".update_success"
    redirect_to send("#{current_user.type.downcase}_root_path")
  end

  private

  def profile_params
    params.require(:user_profile).permit :name, :avatar_url, :gender,
      :birthday, :address, :phone
  end

  def find_user
    return if @user = User.find_by(id: params[:user_id])
    flash[:danger] = t ".user_not_found"
    redirect_to root_path
  end

  def find_profile
    return if @profile = UserProfile.find_by(id: params[:id])
    flash[:danger] = t ".profile_not_found"
    redirect_to send("#{current_user.type.downcase}_root_path")
  end
end
