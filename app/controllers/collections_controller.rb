class CollectionsController < ApplicationController
  before_action :set_collection, only: [:destroy, :show, :edit, :update]

  def show; end

  def new
    @collection = Collection.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
    @collection.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end
end
