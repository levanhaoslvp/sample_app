# frozen_string_literal: true

module Users
  # OmniauthCallbacksController
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include OmniauthHelper
    def facebook
      generic_callback('facebook')
    end

    def google_oauth2
      generic_callback('google_oauth2')
    end

    private

    def generic_callback(provider)
      auth = request.env['omniauth.auth']
      @identity = User.from_omniauth(auth)
      check_provider(auth)
      @user = @identity || current_user
      check_user_existed(auth, provider)
    end

    def check_user_existed(auth, provider)
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        session['provider'] = auth.provider
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end
end
