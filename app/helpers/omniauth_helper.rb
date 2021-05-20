# frozen_string_literal: true

module OmniauthHelper
  def check_provider(auth)
    user = User.find_by(email: auth.info.email)
    if Provider.find_by(uid: auth.uid, provider: auth.provider)
      user.providers.update_avatar(auth.info.image)
    else
      Provider.create(uid: auth.uid, provider: auth.provider, user_id: user.id, avatar: auth.info.image)
    end
  end

  # def user_auths(auth)
  #   User.joins(:providers).select('users.*,providers.*').where(providers: { uid: auth.uid }).first
  # end
end
