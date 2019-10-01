# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :initialize_search, only: %i[index search]

  def index
    @users = User.order(:name).page(params[:page])
  end

  def search
    @users = @q.result(distinct: true).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(:title).page(params[:page])
  end

  def profile
    @user = current_user
    @articles = @user.articles.page(params[:page])
  end

  private

  def initialize_search
    @q = User.ransack(params[:q])
  end
end
