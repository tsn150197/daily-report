class ReportsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reports_#{params['report_id']}_channel"
  end

  def send_comment data
    comment = current_user.comments.build content: data["comment"],
      report_id: data["report_id"]

    return unless comment.save
    ActionCable.server.broadcast "reports_#{comment.report.id}_channel",
      user_name: comment.user.user_profile.name, comment: comment.content,
      created_at: I18n.l(comment.created_at, format: :datetime)
  end
end
