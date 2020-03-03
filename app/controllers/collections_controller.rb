class CollectionsController < ApplicationController
  before_action :set_collection, only: [:destroy, :show, :edit, :update]

  def show; end

  def new
    @collection = Collection.new
  end

  def create
    @collection = collection.new(collection_params)
    @collection.user = current_user

    if @collection.save
      redirect_to collection_path(@collection)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @collection.update(collection_params)
      redirect_to collection_path(@collection)
    else
      render :edit
    end
  end

  def delete
    @collection.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :user)
  end
end
