class Trainee::ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :trainee?

  def new
    @report = current_user.reports.build status: 0
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

  private

  def report_params
    params.require(:report).permit :title, :date, :content, :status
  end
end
