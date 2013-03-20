class UsersController < ApplicationController
  # before_filter :authenticate_user!
  before_filter :require_admin!, :only => [:new, :edit, :create, :update]

  def index
    # I would never request all records in an actual application.
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new()
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save 
      redirect_to user_path(@user), notice: 'Saved!  You\'re awesome!'
    else
      flash.now[:alert] = 'Oh no!  Something wasn\'t quite right'
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user]) 
      redirect_to @user, notice: 'Saved!  You\'re awesome!'
    else
      flash.now[:alert] = 'Ayee yeeah! Something wasn\'t quite right!'
      render action: 'edit'
    end
  end
end
