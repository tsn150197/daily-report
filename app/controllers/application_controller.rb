class ApplicationController < ActionController::Base
  include LoginsHelper
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "login_fail"
    redirect_to root_path
  end

  def admin?
    redirect_to root_path unless current_user.is_a? Admin
  end

  def trainer?
    redirect_to root_path unless current_user.is_a? Trainer
  end
end
