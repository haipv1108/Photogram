class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments.order(created_at: :asc)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      create_notification @post
      flash[:success] = "You commented the hell out of that post!"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = "Check the comment form, something went horribly wrong."
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def create_notification (post)
    return if post.user == current_user
    Notification.create(user: post.user,
                        notified_by: current_user,
                        post: post,
                        notice_type: 'comment')
  end
end
