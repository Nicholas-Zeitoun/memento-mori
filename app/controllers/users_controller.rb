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
    top_danks = DankRank.order('total_score DESC').limit(6)
    # For each top dank_rank, retrieve [lvl, points, id]
    top_users = top_danks.map { |dank| [User.find(dank.user_id).dank_rank.total_score, User.find(dank.user_id).dank_rank.rank_up_xp_progress, User.find(dank.user_id).id] }
    # Sort that array by level and then points
    top_users.sort!{|a, b| b <=> a}
    # Return the users
    return top_users.map { |array| User.find(array[2]) }
  end

  def top_ten_creation
    # Get top 6 creation scores
    top_creations = DankRank.order('creation DESC').limit(6)
    # For each top creation, retrieve [lvl, points, id]
    top_users = top_creations.map { |dank| [User.find(dank.user_id).dank_rank.total_score, User.find(dank.user_id).dank_rank.rank_up_xp_progress, User.find(dank.user_id).id] }
    # Sort that array by level and then points
    top_users.sort!{|a, b| b <=> a}
    # Return the users
    return top_users.map { |array| User.find(array[2]) }
  end

  def top_ten_collection
    # Get top 6 collection scores
    top_collections = DankRank.order('collection DESC').limit(6)
    # For each top collections, retrieve [lvl, points, id]
    top_users = top_collections.map { |dank| [User.find(dank.user_id).dank_rank.total_score, User.find(dank.user_id).dank_rank.rank_up_xp_progress, User.find(dank.user_id).id] }
    # Sort that array by level and then points
    top_users.sort!{|a, b| b <=> a}
    # Return the users
    return top_users.map { |array| User.find(array[2]) }
  end

  def top_ten_engagement
    # Get top 6 engagement scores
    top_engagements = DankRank.order('engagement DESC').limit(6)
    # For each top engagement, retrieve [lvl, points, id]
    top_users = top_engagements.map { |dank| [User.find(dank.user_id).dank_rank.total_score, User.find(dank.user_id).dank_rank.rank_up_xp_progress, User.find(dank.user_id).id] }
    # Sort that array by level and then points
    top_users.sort!{|a, b| b <=> a}
    # Return the users
    return top_users.map { |array| User.find(array[2]) }
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
