# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to profile_path
    else
      @q = @user.articles.ransack(params[:q])
      @articles = @q.result(distinct: true).page(params[:page])
    end
  end

  def profile
    @user = current_user
    @q = @user.articles.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end
end
