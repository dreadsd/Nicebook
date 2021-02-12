class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = []
    current_user.friends.each do |friend|
      @posts += friend.posts
    end unless current_user.friends.empty?
    @posts += current_user.posts
    @posts.shuffle!
    @post = Post.new
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_back(fallback_location: root_path)
    else
      flash.now[:error] = "Could not save post"
      @posts = Post.all
      render :index
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      flash.now[:error] = "Could not update post"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :author_id)
  end
end
