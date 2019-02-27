class Trainee::ReportsController < ApplicationController
  def index
  end

  def new
    @report = current_user.reports.build
  end

  def create
  end
end
