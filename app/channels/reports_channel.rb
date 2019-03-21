class ReportsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reports_#{params['report_id']}_channel"
  end

  def send_comment data
    comment = build_comment data

    return unless comment.save
    ActionCable.server.broadcast "reports_#{comment.report.id}_channel",
      user_name: current_user.user_profile.name, comment: comment.content,
      created_at: I18n.l(comment.created_at, format: :datetime),
      user_avatar: check_avatar(comment), comment_id: comment.id,
      user_id: current_user.id
  end

  def delete_comment data
    comment = current_user.comments.find_by id: data["comment_id"]

    return unless comment.destroy
    ActionCable.server.broadcast "reports_#{comment.report.id}_channel",
      comment_id: comment.id, delete: true
  end

  private

  def check_avatar comment
    if comment.user.user_profile.avatar_url.url
      comment.user.user_profile.avatar_url.url
    else
      "/assets/default_avatar.png"
    end
  end

  def build_comment data
    current_user.comments.build content: data["comment"],
      report_id: data["report_id"]
  end
end
