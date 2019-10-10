# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :initialize_article, only: %i[edit show update destroy]
  before_action :can_change_article?, only: %i[edit update destroy]

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = current_user.articles.new(article_params)
    @article.likes_count = 0
    @article.save
    respond_to do |format|
      format.js
    end
  end

  def show
    @comments = @article.comments.eager_load(:user).order(:created_at)
  end

  def index
    @q = Article.order(:created_at).reverse_order.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.js
    end
  end

  def mypage
    @user = current_user
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def initialize_article
    @article = Article.find(params[:id])
  end

  def can_change_article?
    head 403 unless @article.user == current_user
  end
end
