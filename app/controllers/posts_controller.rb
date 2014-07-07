class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    @posts = Post.new(posts_params)
    @posts.save
    redirect_to @posts
    # render plain: params[:posts].inspect
  end

  def show
    @posts = Post.find(params[:id])
  end

  private
  def posts_params
    params.require(:posts).permit(:title, :description)
  end
end