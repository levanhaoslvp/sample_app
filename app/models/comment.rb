class Comment < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :post

  validates :user, presence: true
  validates :content, presence: true

  acts_as_tree order: "created_at ASC"
end
