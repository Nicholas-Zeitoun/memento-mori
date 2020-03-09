class CollectionsController < ApplicationController
  before_action :set_collection, only: [:destroy, :show, :edit, :update, :follow, :unfollow]

  def show; end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user

    if @collection.save
      raise
      current_user.set_dank_rank
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

  def destroy
    @collection.destroy
    redirect_to user_path(current_user)
  end

  # Functionality calling AJAX for following collections
  def follow
    if @collection.follow(current_user.id)
      current_user.set_dank_rank
      @collection.user.set_dank_rank
      respond_to do |format|
        format.html { redirect_to collection_path(@collection) }
        format.js
      end
    end
  end

  def unfollow
    if @collection.unfollow(current_user.id)
      current_user.set_dank_rank
      @collection.user.set_dank_rank
      respond_to do |format|
        format.html { redirect_to collection_path(@collection) }
        format.js
      end
    end
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :user)
  end

end
