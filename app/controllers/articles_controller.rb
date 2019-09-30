class ArticlesController < ApplicationController
  before_action :initialize_article, only: [:edit, :show, :update, :destroy]
  before_action :can_change_article?, only: [:edit, :update, :destroy]
  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @comments = @article.comments.eager_load(:user)
  end

  def index
    @articles = Article.order(:user_id).page(params[:page])
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

    redirect_to articles_path
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
    # return resource_not_found unless @article.present?
  end

  def can_change_article?
    head 403 unless @article.user == current_user
  end
end
