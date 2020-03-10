class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [ :show, :stats ]

  def index
    @users = User.all
  end

  def show; end

  def stats; end

  def leaderboard
    # Get top 3 dank ranks total scores
    top_danks = DankRank.order('total_score DESC').limit(6)
    # For each top dank_rank, retrieve user
    @users = top_danks.map do |dank|
      User.find(dank.user_id)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
