class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [ :show, :stats ]

  def index
    @users = User.all
  end

  def show; end

  def stats; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
