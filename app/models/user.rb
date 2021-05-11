# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  # frozen_string_literal: true
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token, :activation_token

  before_create :create_activation_digest
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { minimum: 5, maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # for login with facebook,google,..
  def self.sign_in_from_omniauth(temp_auth)
    User.find_by(provider: temp_auth['provider'], uid: temp_auth['uid']) || create_user_from_omniauth(temp_auth)
  end

  def self.create_user_from_omniauth(temp_auth)
    random_pass = SecureRandom.hex(8)
    random_string = (0...4).map { rand(65..90).chr }.join
    User.create(
      provider: temp_auth['provider'],
      uid: temp_auth['uid'],
      name: temp_auth['info']['name'] || "Guest#{random_string.to_s.downcase}",
      email: random_string.to_s.downcase + temp_auth['info']['email'].to_s,
      password: random_pass.to_s + random_string.to_s.downcase,
      password_digest: random_pass.to_s + random_string.to_s.downcase
    )
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    part_of_feed = 'relationships.follower_id = :id or microposts.user_id = :id'
    Micropost.joins(user: :followers).where(part_of_feed, { id:
    id })
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other=user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Activates an account
  def activate
    # update_columns(activated: FILL_IN, activated_at: FILL_IN)
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
