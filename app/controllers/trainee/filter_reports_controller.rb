class Trainee::FilterReportsController < ApplicationController
  before_action :where_title, :where_from_date, :where_status
  def index
    @reports = @reports.order_date.page(params[:page])
                       .per Settings.user_pagination
    respond_to do |format|
      format.js
    end
  end

  private

  def where_title
    @reports = current_user.reports.where_title params[:title]
  end

  def where_from_date
    @reports = @reports.where_from_date(params[:from_date]) if
      params[:from_date].present?
    @reports = @reports.where_to_date params[:to_date] if
      params[:to_date].present?
  end

  def where_status
    @reports = @reports.send(params[:approve].downcase.to_s) if
      params[:approve].present?
  end
end
