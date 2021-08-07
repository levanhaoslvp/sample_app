class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform noti, count
    ActionCable.server.broadcast "notifications:#{noti.recipient_id}",
                                 {html: render_noti(noti),
                                  counter: render_counter(count, noti)}
  end

  private

  def render_noti noti
    ApplicationController.render_with_signed_in_user(
      noti.recipient,
      partial: "notifications/#{noti.action}",
      locals: {notification: noti, user_recipient: noti.recipient},
      formats: [:html]
    )
  end

  def render_counter count, noti
    ApplicationController.render_with_signed_in_user(
      noti.recipient,
      partial: "notifications/counter",
      locals: {recipient: noti.recipient, counter: count},
      formats: [:html]
    )
  end
end
