class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Create post was successfully"
      redirect_to posts_path
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was updated successfully"
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :caption)
    end
end