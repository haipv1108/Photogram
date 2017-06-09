class PostsController < ApplicationController

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

  end

  def destroy

  end

  private
    def set_post

    end

    def post_params
      params.require(:post).permit(:image, :caption)
    end
end