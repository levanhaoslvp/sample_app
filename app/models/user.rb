# frozen_string_literal: true

# Model User
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :omniauthable, :trackable,
         :confirmable, omniauth_providers: %i[google_oauth2 facebook]
  acts_as_voter

  has_many :providers, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships,
                       source: :followed
  has_many :followers, through: :passive_relationships,
                       source: :follower
  has_many :notifications, as: :recipient

  CSV_ATT = %w[name created_at].freeze

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def self.follower_a_month_ago(user)
    find_by(id: user.id).followers
                        .select('name, relationships.created_at')
                        .joins(:active_relationships)
                        .merge(Relationship.month_ago)
  end

  def self.following_a_month_ago(user)
    find_by(id: user.id).following
                        .select('name, relationships.created_at')
                        .joins(:passive_relationships)
                        .merge(Relationship.month_ago)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
