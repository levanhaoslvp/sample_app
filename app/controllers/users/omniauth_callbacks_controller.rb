# frozen_string_literal: 
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      session['provider'] = auth.provider
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
