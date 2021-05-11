# frozen_string_literal: true

module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_in_auth(auth)
    session[:omniauth] = auth.except('extra')
    temp_auth = auth.except('extra')
    user = User.sign_in_from_omniauth(temp_auth)
    session[:user_id] = user['id']
    session[:avatar_url] = temp_auth['info']['image']
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user && user == current_user
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:avatar_url)
    session.delete(:omniauth)
    session.delete(:user_id)
    @current_user = nil
  end
end
