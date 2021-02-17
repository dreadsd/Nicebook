class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  def show
    render layout: "show_comment"
  end

  def edit
    render layout: "show_comment"
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:error] = "Could not create comment"
      raise flash[:error]
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:author_id, :commentable_id, :commentable_type, :body)
  end
end
