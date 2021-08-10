# frozen_string_literal: true

# Model Comment
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, as: :notifiable
  validates :user, presence: true
  validates :content, presence: true
  validates :post, presence: true

  acts_as_votable
  acts_as_tree order: 'created_at ASC'
end
