# frozen_string_literal: true

# app/controllers/VotesController
class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :type_status
  def index; end

  def create
    @status.liked_by current_user
    create_notification
    res_reaction
  end

  def destroy
    @status.disliked_by current_user
    res_reaction
  end

  private

  def type_status
    @post = Post.find_by id: params[:post_id]
    @comment = Comment.find_by id: params[:comment_id]
    @status = @post || @comment
  end

  def res_reaction
    if params[:post_id].present?
      respond_to do |format|
        format.js { render :vote_post }
      end
    else
      respond_to do |format|
        format.js { render :vote_comment }
      end
    end
  end

  def create_notification
    Notification.create(
      recipient: @status.user, user: current_user,
      action: 'reaction', viewed: false, notifiable: @status,
      post_id: @status.id, comment_id: @status.id
    )
  end
end
