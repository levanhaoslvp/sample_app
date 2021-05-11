# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token, only: :create
  # protect_from_forgery with: :exception
  include SessionHelper

  # app/controller/application

  # app hello
  def hello
    render html: 'hello, world!'
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
