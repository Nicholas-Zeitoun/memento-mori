class CategoriesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_category, only: [:destroy, :show, :follow, :unfollow]

  def index
    @categories = Category.all
    @top_ten_users = top_ten_users
  end

  def show
    @memes = @category.memes
    @collect = Collect.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def destroy
    @category.destroy
    redirect_to user_path(current_user)
  end

  # Functionality calling AJAX for following users
  def follow
    if @category.follow(current_user.id)
      current_user.set_dank_rank
      respond_to do |format|
        format.html { redirect_to category_path(@category) }
        format.js
      end
    end
  end

  def unfollow
    if @category.unfollow(current_user.id)
      current_user.set_dank_rank
      respond_to do |format|
        format.html { redirect_to category_path(@category) }
        format.js
      end
    end
  end

  private

  def top_ten_users
    # Get top 3 dank ranks total scores
    top_danks = DankRank.order('total_score DESC').limit(6)
    # For each top dank_rank, retrieve [lvl, points, id]
    top_users = top_danks.map { |dank| [User.find(dank.user_id).dank_rank.total_score, User.find(dank.user_id).dank_rank.rank_up_xp_progress, User.find(dank.user_id).id] }
    # Sort that array by level and then points
    top_users.sort!{|a, b| b <=> a}
    # Return the users
    return top_users.map { |array| User.find(array[2]) }
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :user)
  end
end
