# frozen_string_literal: true

# Model Relationship
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  scope :month_ago,
        -> { where('relationships.created_at > ?', 1.month.ago) }
end
