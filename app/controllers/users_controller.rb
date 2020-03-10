class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]
  #skip_before_action :authenticate_user!, only: [:show]

  def index
    @users = users_ordered_by_dank
    @top_ten_users = top_ten_users
    @top_ten_creations = top_ten_creation
    @top_ten_collections = top_ten_collection
    @top_ten_engagements = top_ten_engagement
  end

  def show
    @user = User.find(params[:id])
  end


  # Functionality calling AJAX for following users
  def follow
    if current_user.follow(@user.id)
      current_user.set_dank_rank
      @user.set_dank_rank #setting dank rank of followed user
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      current_user.set_dank_rank
      @user.set_dank_rank #setting dank rank of unfollowed user
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: :follow }
      end
    end
  end

  # Retrieving top 3 users based on their dank_rank.total_score
  def top_ten_users
    # Get top 3 dank ranks total scores
    # Get top 3 dank ranks total scores
    top_danks = DankRank.order('total_score DESC').limit(6)
    # For each top dank_rank, retrieve user
    return top_danks.map do |dank|
      User.find(dank.user_id)
    end
  end

  def top_ten_creation
    # Get top 6 creation scores
    top_creations = DankRank.order('creation DESC').limit(6)
    # For each top creation, retrieve user
    return top_creations.map do |dank|
      User.find(dank.user_id)
    end
  end

  def top_ten_collection
    # Get top 6 collection scores
    top_collections = DankRank.order('collection DESC').limit(6)
    # For each top collection, retrieve user
    return top_collections.map do |dank|
      User.find(dank.user_id)
    end
  end

  def top_ten_engagement
    # Get top 6 engagement scores
    top_engagements = DankRank.order('engagement DESC').limit(6)
    # For each top engagement, retrieve user
    return top_engagements.map do |dank|
      User.find(dank.user_id)
    end
  end

  private
  # Setting the user to follow/unfollow
  def set_user
    @user = User.find(params[:id])
  end

  # Retrieving top 10 users based on their dank_rank.total_score
  def users_ordered_by_dank
    # Get top 3 dank ranks total scores
    top_danks = DankRank.order('total_score DESC')
    # For each top dank_rank, retrieve user
    top_danks.map do |dank|
      User.find(dank.user_id)
    end
  end
end
