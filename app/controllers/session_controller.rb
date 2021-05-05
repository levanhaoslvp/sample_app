# frozen_string_literal: true

class SessionController < ApplicationController
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    # Log the user in and redirect to the user's show page.
    else
      flash.now[:danger] = 'Invalid email/password combination'
      # Create an error message.
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
