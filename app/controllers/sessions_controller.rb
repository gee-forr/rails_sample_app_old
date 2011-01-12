class SessionsController < ApplicationController
  protect_from_forgery
  include SessionsHelper

  def new
    @title = 'Sign in'
  end

  def create
    email    = params[:session][:email]
    password = params[:session][:password]
    user     = User.authenticate(email, password)

    if user.nil?
      # flash.now is used because this is a render, and not a redirect.
      # Using normal flash will persist the flash message for two requests.
      flash.now[:error] = "Invalid email/password combination."
      @title            = "Sign in"
      
      render :new
    else
      sign_in     user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
