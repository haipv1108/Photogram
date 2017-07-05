class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def d estroy
    @post.destroy
    redirect_to root_path
  end

  def like
    # current_user.vote(@post, :up)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unlike
    # current_user.unvote(@post, :up)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

end
