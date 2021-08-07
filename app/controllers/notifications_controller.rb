class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def create
    Notification.update_viewed(current_user)
    @notification = Notification.get_new(current_user)
    respond_to do |format|
      format.js
      format.html{redirect_back fallback_location: root_path}
    end
  end
end
