class CollectsController < ApplicationController
  def create
    unless params[:collect][:collection][:name].empty?
      newcol = Collection.create!(name: params[:collect][:collection][:name], user: current_user)
      @collect = Collect.new(collect_params)
      @collect.collection = newcol
      @meme = Meme.find(params[:meme_id])
      @collect.meme = @meme
    else
      @collect = Collect.new(collect_params)
      @meme = Meme.find(params[:meme_id])
      @collect.meme = @meme
    end

    if @collect.save
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.js  # <-- will render `app/views/collects/create.js.erb`
      end
    end
    @collect.meme.update_rarity
    @collect.collection.user.set_dank_rank
    @collect.meme.user.set_dank_rank
  end

  def destroy
    @collect = Collect.find(params[:id])
    @collection =  @collect.collection
    @collect.destroy
    redirect_to user_collection_path(current_user, @collection)
  end

  private

  def collect_params
    params.require(:collect).permit(:collection_id, :meme)
  end
end

