class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    comment_meme = Meme.find(params[:meme_id])
    @comment.meme_id = params[:meme_id]

    if @comment.save
      comment_meme.update_rarity
      current_user.set_dank_rank
      redirect_to meme_path(params[:meme_id])
    else
      redirect_to meme_path(params[:meme_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
