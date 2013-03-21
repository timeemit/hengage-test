class TimeBlocksController < ApplicationController
  def index
    @time_blocks = current_user.time_blocks
  end

  def show
    @time_block = current_user.time_blocks.where(:id => params[:id]).first
  end

  def new
    @time_block = TimeBlock.new
  end

  def edit
    @time_block = current_user.time_blocks.where(:id => params[:id]).first
  end

  def create
    @time_block = current_user.time_blocks.build(params[:time_block])

    if @time_block.save
      redirect_to @time_block, notice: 'Time Block saved!  Woohoo!'
    else
      flash[:error] = 'Blast!  Something wasn\'t quite right'
      render action: "new"
    end
  end

  def update
    @time_block = current_user.time_blocks.where(:id => params[:id]).first

    if @time_block.update_attributes(params[:time_block])
      redirect_to @time_block, notice: 'Time block was successfully updated.'
    else
      flash[:error] = 'Shoot!  Something wasn\'t quite right'
      render action: "edit" 
    end
  end

  def destroy
    @time_block = current_user.time_blocks.where(:id => params[:id]).first
    @time_block.destroy
    redirect_to time_blocks_url, notice: 'The Time Block has been destroyed!  Yaarrr!'
  end
end
