# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :omniauthable,
         :confirmable, omniauth_providers: %i[google_oauth2 facebook]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data == session['devise.facebook_data'] &&
         session['devise.facebook_data']['extra']['raw_info'] && user.email.blank?
        user.email = data['email']
      end
    end
  end

  def self.from_omniauth(auth)
    puts " this is   #{auth.info} + this is #{auth.info.name}"
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.provider + auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.uid = auth.uid
      user.skip_confirmation!
    end
  end
end
