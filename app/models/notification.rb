class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true
  validates :user, presence: true
  validates :recipient, presence: true
  validates :notifiable, presence: true
  after_commit ->{commit_callback}

  def commit_callback
    count = Notification.where(recipient_id: recipient.id, viewed: false).count
    NotificationRelayJob.perform_later(self, count)
    NotificationsMailer.send_notification(user).deliver_now
  end
end
