# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def create
    @user = User.new(params_new) # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def params_new
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
