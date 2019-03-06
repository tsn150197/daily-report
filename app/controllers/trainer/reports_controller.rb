class Trainer::ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :trainer?
  before_action :check_report, only: %i(show destroy)

  def index
    @reports = []
    current_user.teams.map do |team|
      users = team.trainees
      users&.map do |user|
        @reports += user.reports
      end
    end
    @reports = Kaminari.paginate_array(@reports).page(params[:page])
                       .per Settings.user_pagination
  end

  def show
    @status = Report.human_enum_name(:status, :"#{@report.status}")
    @comment = Comment.new
  end

  def destroy
    if @report.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to trainer_reports_path
  end

  private

  def check_report
    return if (@report = Report.find_by(id: params[:id]))
    flash[:danger] = t ".report_not_found"
    redirect_to trainer_reports_path
  end
end
