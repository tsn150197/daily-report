class Trainee::BulkReportsController < ApplicationController
  before_action :logged_in_user
  before_action :trainee?

  def destroy
    if params[:id].present?
      report_ids = params[:id].split(",")
      reports = current_user.reports.where id: report_ids
      reports.map do |report|
        handle_report report
      end
    else
      flash[:danger] = t ".not_find_report"
    end
    redirect_to trainee_reports_path
  end

  private

  def handle_report report
    if report.status == "rejected" && report.destroy
      flash[:success] = t ".delete_reports"
    elsif report.status != "rejected"
      flash[:warning] = t ".status_approved"
    else
      flash[:danger] = t ".not_delete"
    end
  end
end
