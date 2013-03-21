class TimeBlocksController < ApplicationController
  def index
    @time_blocks = TimeBlock.all
  end

  def show
    @time_block = TimeBlock.find(params[:id])
  end

  def new
    @time_block = TimeBlock.new
  end

  def edit
    @time_block = TimeBlock.find(params[:id])
  end

  def create
    @time_block = TimeBlock.new(params[:time_block])

    if @time_block.save
      redirect_to @time_block, notice: 'Time block was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @time_block = TimeBlock.find(params[:id])

    if @time_block.update_attributes(params[:time_block])
      redirect_to @time_block, notice: 'Time block was successfully updated.'
    else
      render action: "edit" 
    end
  end

  def destroy
    @time_block = TimeBlock.find(params[:id])
    @time_block.destroy
    redirect_to time_blocks_url
  end
end
