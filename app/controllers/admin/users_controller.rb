class Admin::UsersController < ApplicationController
  before_action :admin?

  def new
    @user = User.new
    tranfer_data
  end

  def create
    @user = User.new user_params

    if params[:teams].present? && @user.save
      save_user_team @user, params[:teams]
    else
      handle_fail
      tranfer_data
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation,
      :type
  end

  def save_user_team user, teams = {}
    teams.each do |team|
      user.user_team Team.find_by(name: team)
    end
    flash[:success] = t ".success"
    redirect_to new_admin_user_path
  end

  def admin?
    redirect_to "#" unless current_user.is_a? Admin
  end

  def tranfer_data
    @type = %w(Trainer Trainee)
    @teams = Team.all.pluck :name
  end

  def handle_fail
    if params[:teams].present?
      flash.now[:info] = t ".error"
    else
      flash.now[:danger] = t ".no_check_box"
    end
  end
end
