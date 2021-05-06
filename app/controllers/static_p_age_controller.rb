# frozen_string_literal: true

# app/controllers/static_p_age.rb

class StaticPAgeController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page:
      params[:page])
    end
  end

  def help; end

  def about; end

  def contact; end
end
