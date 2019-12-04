# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, raise: false
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

  def destroy
    @user = User.find(params[:id])
    Following.where(user_id: @user.id).destroy_all
    Following.where(followed_user_id: @user.id).destroy_all
    @user.destroy
    redirect_to users_path
  end

  def profile
    @user = current_user
    @q = @user.articles.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def edit
    @user = current_user
    render 'edit'
  end

  def update
    if current_user.update_with_password(user_params)
      bypass_sign_in(current_user)
      flash.keep[:success] = 'Updated successfully'
      redirect_to profile_path
    else
      flash.keep[:wrong_password] = 'Wrong current password'
      redirect_to profile_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :current_password)
  end
end
