class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :user
  def create
    viewed_noti
    @notification = Notification.where(recipient_id: @user.id, viewed: false)
    respond_to do |format|
      format.js
      format.html{redirect_back fallback_location: root_path}
    end
  end
  private

  def user
    @user = User.find_by(id: params[:id])
  end

  def viewed_noti
    noti = Notification.where(recipient_id: @user.id, viewed: false)
    noti.map do |member|
      member.viewed = true
      member.save
    end
  end
end
