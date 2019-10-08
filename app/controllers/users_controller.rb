# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @q = @user.articles.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def profile
    @user = current_user
    @q = @user.articles.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end
end
