# frozen_string_literal: true

# CommentsHelper
module CommentsHelper
  def comments_tree_for(comments)
    safe_join(
      comments.map do |comment, _nested_comments|
        child = comment.children
        render(comment, post: comment.post, comment_new: Comment.new) +
          (tag.div(comments_tree_for(child), class: 'replies') if child)
      end
    )
  end
end
