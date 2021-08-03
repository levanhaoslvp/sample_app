class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true
  validates :user, presence: true
  validates :recipient, presence: true
  validates :notifiable, presence: true
  scope :get_of, ->(user){where(recipient_id: user.id).reverse}
  scope :get_new, ->(user){where(recipient_id: user.id, viewed: false)}

  after_commit ->{commit_callback}

  def commit_callback
    count = Notification.where(recipient_id: recipient.id, viewed: false).count
    NotificationRelayJob.perform_later(self, count)
    NotificationsMailer.send_notification(user).deliver_now
  end

  def self.update_viewed user
    noti = Notification.where(recipient_id: user.id, viewed: false)
    noti.map do |member|
      member.viewed = true
      member.save
    end
  end
end
