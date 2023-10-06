class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.order("created_at DESC")
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to admin_comments_path, notice: "Comment deleted."
    else
      redirect_to [:admin, @comment], notice: "Failed to delete comment."
    end
  end
end
