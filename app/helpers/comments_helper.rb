module CommentsHelper
  def comments_children comments
    safe_join(comments.map do |comment|
      render(partial: "comments/comment_reply", object: comment)
    end)
  end
end
