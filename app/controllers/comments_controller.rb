# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :initialize_article, only: %i[destroy create]

  def index
    @comments = Comment.order(:body).page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!
    respond_to do |format|
      format.js
    end
    # @comment.save
    # redirect_to article_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:body)
  end

  def initialize_article
    @article = Article.find(params[:article_id])
  end
end
