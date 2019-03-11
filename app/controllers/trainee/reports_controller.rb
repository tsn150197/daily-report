class Trainee::ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :trainee?
  before_action :check_report, only: %i(show edit update destroy)

  def index
    @status = [nil]
    Report.statuses.keys.each do |status|
      @status << Report.human_enum_name(:status, :"#{status}")
    end
    @reports = current_user.reports.order_date.page(params[:page])
                           .per Settings.user_pagination
  end

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

  def show
    @status = Report.human_enum_name(:status, :"#{@report.status}")
    @comment = Comment.new
  end

  def edit
    return if @report.status == "rejected"
    flash[:danger] = t ".report_not_found_status"
    redirect_to trainee_root_path
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

  def destroy
    if @report&.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_danger"
    end
    redirect_to trainee_reports_path
  end

  private

  def report_params
    params.require(:report).permit :title, :date, :content, :status
  end

  def check_report
    return if (@report = current_user.reports.find_by id: params[:id])
    flash[:danger] = t ".report_not_found"
    redirect_to trainee_reports_path
  end
end
