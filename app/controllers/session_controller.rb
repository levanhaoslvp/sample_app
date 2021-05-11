# frozen_string_literal: true

class SessionController < ApplicationController
  def new
    render 'new'
  end

  def create
    if request.env['omniauth.auth']
      auth = request.env['omniauth.auth']
      log_in_auth auth
      redirect_to root_url
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          if params[:session][:remember_me] == '1'
            remember(user)
          else
            forget(user)
          end
          redirect_to user
        else
          message = 'Account not activated. '
          message += 'Check your email for the activation link.'
          flash[:warning] = message
          redirect_to root_url
        end
      # Log the user in and redirect to the user's show page.
      else
        flash.now[:danger] = 'Invalid email/password combination'
        # Create an error message.
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
