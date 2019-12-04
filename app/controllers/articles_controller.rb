# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :initialize_article, only: %i[edit show update destroy retweet destroy_retweet]
  before_action :can_change_article?, only: %i[edit update destroy]
  before_action :authenticate_user!

  def new
    @article = Article.new
    authorize @article
  end

  def edit; end

  def create
    @article = current_user.articles.new(article_params)
    @article.likes_count = 0
    authorize @article
    @article.save
    respond_to do |format|
      format.js
    end
  end

  def show
    @comments = @article.comments.eager_load(:user).order(:created_at)
    redirect_to article_path(@article.retweeted_id) if @article.retweeted_id.present?
  end

  def index
    @q = Article.where(user: current_user.followed_users).or(Article.where(user: current_user)).order(:created_at).reverse_order.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
    authorize @articles
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    Article.where(retweeted_id: @article.id).destroy_all
    @article.destroy
    respond_to do |format|
      format.js
    end
  end

  def mypage
    @user = current_user
  end

  def retweet
    @retweet = create_retweet_command.call(
      article: @article,
      user: current_user
    ).retweet
    respond_to do |format|
      format.js
    end
  end

  def destroy_retweet
    destroy_retweet_command.call(@article)
    respond_to do |format|
      format.js
    end
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

  def create_retweet_command
    @create_retweet_command ||= RetweetManagement::Create.new
  end

  def destroy_retweet_command
    @destroy_retweet_command ||= RetweetManagement::Destroy.new
  end
end
