# frozen_string_literal: true

# Model Post
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable
  validates :content, length: { in: 5..100 }, presence: true
  validates :title, length: { minimum: 2 }, presence: true
  validates :user, presence: true
  acts_as_votable

  CSV_ATT = %w[content created_at].freeze

  scope :a_month_ago,
        lambda {
          where('created_at > ?', 1.month.ago).select(:content,
                                                      :created_at)
        }
end
