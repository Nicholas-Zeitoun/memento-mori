class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.user = current_user
    @like.meme_id = params[:meme_id]
    if @like.save
        respond_to do |format|
        format.html { redirect_to request.referer }
        format.js
      end
    else
      redirect_to request.referer
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @meme = @like.meme
    @like.destroy
    #redirect_to request.referer
  end

  private

  def likes_params
    params.require(:like).permit(:user, :meme_id)
  end
end

