class UsersController < ApplicationController
  before_filter :require_admin!, :only => [:new, :edit, :create, :update]

  def index
    @users = User.page(params[:page])
  end

  def show
    params[:report].present? ? (@start_time = time_from_params('start_time')) : (@start_time = Time.zone.now - 1.day)
    params[:report].present? ? (@end_time = time_from_params('end_time')) : (@end_time = Time.zone.now)
    @user = User.find(params[:id])
    if @start_time < @end_time
      @user_report = UserReport.new(:user_id => @user.id, :start_time => @start_time, :end_time => @end_time)
    else
      redirect_to user_path(@user), alert: 'The times you\'ve entered don\'t make sense!!!  May get strange response!'
    end
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
