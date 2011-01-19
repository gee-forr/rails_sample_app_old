class UsersController < ApplicationController
  protect_from_forgery
  include SessionsHelper

  before_filter :authenticate,             :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user,             :only => [:edit, :update]
  before_filter :admin_user,               :only => :destroy
  before_filter :redirect_signed_in_users, :only => [:create, :new]

  def index
    @users = User.paginate(:page => params[:page])
    @title = 'All users'
  end

  def show
    @user       = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title      = @user.name
  end

  def new
    @user  = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title                      = "Sign up"
      @user.password              = ''
      @user.password_confirmation = ''

      render 'new'
    end

  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  private

    def correct_user 
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def redirect_signed_in_users
      redirect_to(root_path) if signed_in?
    end
end
