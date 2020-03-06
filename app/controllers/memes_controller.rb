class MemesController < ApplicationController
  before_action :set_meme, only: [:destroy, :show, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @memes = Meme.all
    @top_categories = top_categories
    @top_three_users = top_three_users
    @top_three_memes = top_three_memes
    @collect = Collect.new
    @collection = Collection.new
  end

  def show
    @collect = Collect.new
    @collection = Collection.new
  end

  def new
    @meme = Meme.new
    @category = Category.new
  end

  def create
    unless params[:meme][:category][:name].empty?
      newcat = Category.create!(name: params[:meme][:category][:name], user: current_user)
      @meme = Meme.new(meme_params)
      @meme.category = newcat
    else
      @meme = Meme.new(meme_params)
    end
    @meme.user = current_user
    @meme.set_rarity
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
    params.require(:meme).permit(:title, :image_url, :category_id, :user, :image)
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
    top_danks = DankRank.order('total_score DESC').limit(10)
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

#   for future rarity controller
#   def calculate_rarity
#     #rarity = meme.calculate_rarity
#     rarity = (self.likes.count + self.comments.count + ...)
#     self.total_score = rarity
#     self.save!
#   end
