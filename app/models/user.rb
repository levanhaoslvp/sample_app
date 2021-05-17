# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :omniauthable,
         :confirmable, omniauth_providers: %i[google_oauth2 facebook]

  def self.from_omniauth(auth)
    User.find_by(email: auth.info.email) ||
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = Devise.friendly_token[0, 20]
        user.uid = auth.uid
        user.skip_confirmation!
      end
  end
end
