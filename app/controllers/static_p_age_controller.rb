# frozen_string_literal: true

# app/controllers/static_p_age.rb

class StaticPAgeController < ApplicationController
  before_action :set_auth

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help; end

  def about; end

  def contact; end

  private

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
