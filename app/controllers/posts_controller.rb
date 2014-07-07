class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    @posts = Post.new(params[:posts].permit(:title, :description))
    @posts.save
    redirect_to @posts

    # render plain: params[:posts].inspect
  end
end