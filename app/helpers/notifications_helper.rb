module NotificationsHelper
  def notifications_of user
    Notification.where(recipient_id: user.id).reverse
  end

  def notifications_new user
    Notification.where(recipient_id: user.id, viewed: false).reverse
  end
end
