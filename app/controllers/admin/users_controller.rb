class Admin::UsersController < ApplicationController
  before_action :admin?
  before_action :find_user, only: %i(destroy)

  def index
    users = Trainer.all + Trainee.all
    @users = Kaminari.paginate_array(users).page(params[:page])
                     .per(Settings.user_pagination)
  end

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
    end
  end

  def destroy
    if @user&.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_users_path
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
    tranfer_data
    render :new
  end

  def find_user
    return if (@user = User.find_by id: params[:id])
    flash[:danger] = t ".found"
    redirect_to admin_users_path
  end
end
