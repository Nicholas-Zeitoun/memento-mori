class CommentsController < ApplicationController
  def new
  end

  def create
    @meme = Meme.find(params[:meme_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    #comment_meme = Meme.find(params[:meme_id])
    @comment.meme = @meme

    if @comment.save
      respond_to do |format|
        format.html { redirect_to meme_path(params[:meme_id]) }
        format.js  # <-- will render `app/views/comments/create.js.erb`
      end
      # comment_meme.update_rarity
      # current_user.set_dank_rank
    else
      respond_to do |format|
        format.html { redirect_to meme_path(params[:meme_id]) }
        format.js  # <-- idem
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :meme)
  end
end

