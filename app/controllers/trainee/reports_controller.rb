class Trainee::ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :trainee?
  before_action :check_status, only: %i(edit update)

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build report_params

    if @report.save
      flash[:success] = t ".success"
      redirect_to trainee_root_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def edit
    @report = @report.find_by id: params[:id]
  end

  def update
    if @report.update report_params
      flash[:success] = t ".success"
      redirect_to trainee_root_path
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  private

  def report_params
    params.require(:report).permit :title, :date, :content, :status
  end

  def check_status
    return if (@report = current_user.reports.where status: 0)
    flash[:danger] = t ".report_not_found_status"
    redirect_to trainee_root_path
  end
end
