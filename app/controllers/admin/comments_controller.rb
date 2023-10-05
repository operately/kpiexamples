class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.order("created_at DESC")
  end
end
