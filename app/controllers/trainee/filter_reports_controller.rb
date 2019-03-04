class Trainee::FilterReportsController < ApplicationController
  def create
    @reports = current_user.reports.where_title params[:title]
    where_date
    @reports = @reports.send(params[:approve].downcase.to_s) if
      params[:approve].present?
    respond_to do |format|
      format.html{redirect_to trainee_reports_path}
      format.js
    end
  end

  private

  def where_date
    @reports = @reports.where_from_date(params[:from_date]) if
      params[:from_date].present?
    @reports = @reports.where_to_date params[:to_date] if
      params[:to_date].present?
  end
end
