class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, length: {in: 5..100}, presence: true
  validates :title, length: {minimum: 2}, presence: true
  validates :user, presence: true
end
