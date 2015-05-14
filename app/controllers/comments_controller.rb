class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash.notice = "Thanks for successfully adding your comment, #{@comment.author}."
      # redirect_to post_path(@comment.post)
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post) }
        format.js
      end
    else
      flash.notice = "oh no, your comment sucked, please try again."
      render :form
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author)
  end
end
