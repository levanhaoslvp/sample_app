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
      noti.user,
      partial: "notifications/#{noti.action}",
      locals: {notification: noti},
      formats: [:html]
    )
  end

  def render_counter count, noti
    ApplicationController.render(
      partial: "notifications/counter",
      locals: {recipient: noti.recipient, counter: count},
      formats: [:html]
    )
  end
end
