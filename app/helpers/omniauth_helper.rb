# frozen_string_literal: true

module OmniauthHelper
  def check_provider(auth)
    user = User.find_by(email: auth.info.email)
    if user.providers.find_by(provider: auth.provider)
      user.providers.update_avatar(auth.info.image)
    else
      user.providers.create(provider: auth.provider, avatar: auth.info.image)
    end
  end
end
