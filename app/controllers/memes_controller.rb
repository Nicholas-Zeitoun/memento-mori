class MemesController < ApplicationController
  before_action :set_meme, only: [:destroy, :show, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @memes = Meme.search_by_title(params[:query])
      build_feed
    else
      @memes = Meme.all
      build_feed
    end
  end

  def trending
    # Same code than index if we want same rendering
    @users = User.all
    @top_categories = top_categories
    @top_ten_users = top_ten_users
    @top_three_memes = top_three_memes
    @collect = Collect.new
    @collection = Collection.new

    # Order memes by rarity
    top_rarities = Rarity.order('total_score DESC').limit(200)
    @memes = top_rarities.map do |rarity|
      Meme.find(rarity.meme_id)
    end
  end

  def news
    # Same code than index if we want same rendering
    @users = User.all
    @top_categories = top_categories
    @top_ten_users = top_ten_users
    @top_three_memes = top_three_memes
    @collect = Collect.new
    @collection = Collection.new

    # Order memes by date
    @memes = Meme.order('created_at DESC').limit(100)
  end

  def show
    @collect = Collect.new
    @collection = Collection.new
    @like = Like.new
    @comment = Comment.new
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
    if @meme.save
      @meme.set_rarity
      redirect_to meme_path(@meme)
    else
      render :new
    end
    current_user.set_dank_rank
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
    @meme.rarity.destroy
    @meme.collects.destroy_all
    @meme.comments.destroy_all
    @meme.likes.destroy
    @meme.destroy
    redirect_to user_path(current_user)
    current_user.set_dank_rank
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
  def top_ten_users
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

  def build_feed
    @users = User.all
    @top_categories = top_categories
    @top_ten_users = top_ten_users
    @top_three_memes = top_three_memes
    @collect = Collect.new
    @collection = Collection.new
  end

end

#   for future rarity controller
#   def calculate_rarity
#     #rarity = meme.calculate_rarity
#     rarity = (self.likes.count + self.comments.count + ...)
#     self.total_score = rarity
#     self.save!
#   end
