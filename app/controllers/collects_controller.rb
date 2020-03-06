class CollectsController < ApplicationController
  def create
    @collect = Collect.new(collect_params)
    @collect.meme = Meme.find(params[:meme_id])
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
