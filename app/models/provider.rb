# frozen_string_literal: true

# Model Provider
class Provider < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user
  validates :user_id, presence: true
  validates :provider, presence: true

  def self.update_avatar(new_url)
    :avartar => new_url unless new_url == :avatar
  end
end
