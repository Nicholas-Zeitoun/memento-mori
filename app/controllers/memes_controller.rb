class MemesController < ApplicationController
  before_action :set_meme, only: [:destroy, :show, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @memes = Meme.all
    @top_categories = top_categories
    @top_three_users = top_three_users
    @top_three_memes = top_three_memes
  end

  def show; end

  def new
    @meme = Meme.new
  end

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
    params.require(:meme).permit(:title, :image_url, :category, :user, :photo)
  end

  # Retrieving the top 10 categories with highest number of images
  def top_categories
    Category
    .joins(:memes)
    .group(:id)
    .order('COUNT(memes.id) DESC')
    .limit(10)
  end

  # Retrieving top 3 users based on their dank_rank.total_score
  def top_three_users
    # Get top 3 dank ranks total scores
    top_danks = DankRank.order('total_score DESC').limit(3)
    # For each top dank_rank, retrieve user
    top_danks.map do |dank|
      User.find(dank.user_id)
    end
  end

  # Retrieving top 3 memes based on their rarity.total_score
  def top_three_memes
    # Get top 3 rarity total scores
    top_rarities = Rarity.order('total_score DESC').limit(3)
    top_rarities.map do |rarity|
      Meme.find(rarity.meme_id)
    end
  end
end



