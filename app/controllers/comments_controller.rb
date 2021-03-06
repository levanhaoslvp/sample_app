# frozen_string_literal: true

# app/controllers/CommentsController
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :filter_comment, only: [:create]

  def create
    respond_to do |format|
      if @comment.save
        create_notification
        format.js
        format.html { redirect_back fallback_location: root_path }
      else
        format.html { render html: 'does not create comment !' }
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
        format.html { redirect_back fallback_location: root_path }
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

  def filter_comment
    if params[:comment][:parent_id].to_i.positive?
      parent = Comment.find(params[:comment].delete(:parent_id))
      @comment = parent.children.build comment_params
    else
      @comment = Comment.new comment_params
    end
  end

  def create_notification
    object = @comment.parent || @comment.post
    Notification.create(
      recipient: object.user,
      user: current_user,
      action: 'comment', viewed: false, notifiable: @comment,
      post_id: @comment.post_id, comment_id: @comment_id
    )
  end
end
