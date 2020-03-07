class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @users = users_ordered_by_dank
    @top_three_users = top_three_users
  end

  def show
    @user = User.find(params[:id])
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

  private
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
