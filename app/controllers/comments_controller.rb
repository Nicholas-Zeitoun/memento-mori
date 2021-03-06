class CommentsController < ApplicationController
  def new
  end

  def create
    @meme = Meme.find(params[:meme_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.meme = @meme

    if @comment.save
      #@meme.update_rarity
      #current_user.set_dank_rank
      respond_to do |format|
        format.html { redirect_to meme_path(params[:meme_id]) }
        format.js  # <-- will render `app/views/comments/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { redirect_to meme_path(params[:meme_id]) }
        format.js  # <-- idem
      end
    end
    @comment.meme.update_rarity
    @comment.meme.user.set_dank_rank
    @comment.user.set_dank_rank
  end

  def destroy
    @comment = Comment.find(params[:id])
    @meme = @comment.meme
    @comment.destroy
    @comment.meme.update_rarity
    @comment.meme.user.set_dank_rank
    @comment.user.set_dank_rank
    # redirect_to meme_path(@meme)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :meme)
  end
end

