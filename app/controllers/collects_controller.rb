class CollectsController < ApplicationController
  def create
    unless params[:collect][:collection][:name].empty?
      newcol = Collection.create!(name: params[:collect][:collection][:name], user: current_user)
      @collect = Collect.new(collect_params)
      @collect.collection = newcol
      @collect.meme = Meme.find(params[:meme_id])
    else
      @collect = Collect.new(collect_params)
      @collect.meme = Meme.find(params[:meme_id])
    end

    if @collect.save
      redirect_to user_collection_path(current_user, @collect.collection)
    else
      # should re-render the form
      redirect_to meme_path(Meme.find(params[:meme_id]))
    end
  end

  private

  def collect_params
    params.require(:collect).permit(:collection_id, :meme)
  end
end

