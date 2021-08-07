class NotificationsMailer < ApplicationMailer
  def send_notification user
    @user = user
    mail to: user.email, subject: "you just got a new notification"
  end
end
