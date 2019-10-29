# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :initialize_user, only: %i[create destroy]
  def create
    @following = current_user.followings.new(followed_user: @user)
    if @following.save!
      flash[:notice] = 'Added subscribtion.'
      redirect_to users_path
    else
      flash[:error] = 'Unable to add subscribtion.'
      redirect_to users_path
    end
  end

  def destroy
    @following = current_user.followings.find(@user)
    @following.destroy
    flash[:notice] = 'Removed subscribtion.'
    redirect_to root_url
  end

  private

  def initialize_user
    @user = User.find(params[:user_id])
  end
end
