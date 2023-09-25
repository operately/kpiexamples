class CommentsController < ApplicationController

  before_action :require_login

  # for dom_id
  include ActionView::RecordIdentifier

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save

      respond_to do |format|

        format.turbo_stream do

          if @comment.reply?
            render turbo_stream: [
              turbo_stream.append(
                dom_id(@comment.parent, :replies),
                partial: "comments/comment",
                locals: { comment: @comment, commentable_id: @commentable.id, commentable_type: @commentable.class.name }
              ),
              turbo_stream.update(
                "reply_form_for_#{dom_id(@comment.parent)}",
                partial: "comments/form_hidden"
              )
            ]
          else
            render turbo_stream: [
              turbo_stream.append(
                'comments',
                partial: 'comments/comment',
                locals: { comment: @comment, commentable_id: @commentable.id, commentable_type: @commentable.class.name }
              ),
              turbo_stream.update(
                'new_comment_form',
                partial: 'comments/form_hidden'
              )
            ]
          end
        end

        format.html { redirect_to find_parent_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@comment), partial: "comments/form", locals: { comment: @comment, parent_id: @comment.parent_id, commentable_id: @commentable.id, commentable_type: @commentable.class.name  }) }
        format.html { redirect_to find_parent_path, alert: 'There was an error posting your comment.' }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@comment),
            partial: 'comments/comment',
            locals: {
              comment: @comment,
              commentable_id: @comment.commentable_id,
              commentable_type: @comment.commentable_type
            }
          )
        end
        format.html { redirect_to find_parent_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@comment, :edit), partial: "comments/edit_form", locals: { comment: @comment }) }
        format.html { redirect_to find_parent_path, alert: 'There was an error updating your comment.' }
      end
    end
  end

  
  private
  
  def find_commentable
    params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
  end

  def find_parent_path
    params[:return_path]
  end
  
  def comment_params
    params.require(:comment).permit(:content, :parent_id, :commentable_id, :commentable_type)
  end
end

