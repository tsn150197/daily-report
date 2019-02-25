module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".daily_report"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def current_user
    return unless user_id = session[:user_id]
    @current_user ||= User.find_by id: user_id
  end

  def logged_in?
    current_user.present?
  end
end
