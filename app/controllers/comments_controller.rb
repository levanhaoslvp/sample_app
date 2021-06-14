class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: [:destroy]

  def create
    if params[:comment][:parent_id].to_i.positive?
      parent = Comment.find_by id: params[:comment].delete(:parent_id)
      @comment = parent.children.build comment_params
    else
      @comment = Comment.new comment_params
    end

    respond_to do |format|
      if @comment.save
        format.js
      else
        format.html{render @comment}
      end
    end
  end

  def destroy
    @comment.descendants.each(&:destroy)
    @comment.destroy
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.html{redirect_back fallback_location: root_path}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :post_id, :user_id, :content
  end

  def set_comment
    @comment = Comment.find_by id: params[:id]
  end
end
