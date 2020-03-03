class MemesController < ApplicationController
  before_action :set_meme, only: [:destroy, :show, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @memes = Meme.all
  end

  def show; end

  def new; end

  def create
    @meme = Meme.new
    @meme.user = current_user

    if @meme.save
      redirect_to meme_path(@meme)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @meme.update(meme_params)
      redirect_to meme_path(@meme)
    else
      render :edit
    end
  end

  def destroy
    @meme.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_meme
    @meme = Meme.find(params[:id])
  end

  def meme_params
    params.require(:meme).permit(:title, :image_url, :category, :user)
  end
end
