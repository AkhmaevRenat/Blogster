# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :initialize_user, only: %i[create destroy]
  def create
    @following = current_user.followings.new(followed_user: @user)
    if @following.save!
      flash[:notice] = 'Added subscribtion.'
    else
      flash[:error] = 'Unable to add subscribtion.'
    end
    redirect_back(fallback_location: users_path)
  end

  def destroy
    @following = current_user.followings.find_by(followed_user_id: @user.id)
    @following.destroy
    flash[:notice] = 'Removed subscribtion.'
    redirect_back(fallback_location: users_path)
  end

  private

  def initialize_user
    @user = User.find(params[:user_id])
  end
end
