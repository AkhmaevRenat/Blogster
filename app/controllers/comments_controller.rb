class CommentsController < ApplicationController
  before_action :initialize_article, only: [:destroy, :create]
  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article}
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
      format.js
    end
    # @comment.save
    # redirect_to article_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article }
      format.json { head :no_content }
      format.js
    end
  end

  def index
    @comments = Comment.order(:body).page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.required(:comment).permit(:body)
  end

  def initialize_article
    @article = Article.find(params[:article_id])
  end
end
