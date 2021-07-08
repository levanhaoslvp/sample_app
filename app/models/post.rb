class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, length: {in: 5..100}, presence: true
  validates :title, length: {minimum: 2}, presence: true
  validates :user, presence: true
  acts_as_votable

  CSV_ATT = %w(content created_at).freeze

  scope :a_month_ago,
        ->{where("created_at > ?", 1.month.ago).select(:content, :created_at)}
end
