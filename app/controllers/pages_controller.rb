class PagesController < ApplicationController
  protect_from_forgery
  include SessionsHelper

  def home
    @title = 'Home'
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end
end
