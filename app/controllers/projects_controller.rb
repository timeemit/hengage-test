class ProjectsController < ApplicationController
  before_filter :require_admin!, :only => [:new, :edit, :create, :update]
  
  def index
    @projects = Project.all
  end

  def show
    params[:report].present? ? (@start_time = time_from_params('start_time')) : (@start_time = Time.zone.now - 1.day)
    params[:report].present? ? (@end_time = time_from_params('end_time')) : (@end_time = Time.zone.now)
    @project = Project.find(params[:id])
    if @start_time < @end_time
      @project_report = ProjectReport.new(:project_id => @project.id, :start_time => @start_time, :end_time => @end_time)
    else
      redirect_to project_path(@project), alert: 'The times you\'ve entered don\'t make sense!!!'
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      flash[:alert] = 'Oh noes!  Something went wrong.'
      render action: "new"
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      flash[:alert] = 'Gosh Darn!  Something went wrong.'
      render action: "edit"
    end
  end
  
end
