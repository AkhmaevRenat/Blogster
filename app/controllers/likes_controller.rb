# frozen_string_literal: true

class LikesController < ApplicationController
  def new
    @like = Likes.new
  end

  def create; end

  def destroy; end

  def like_decision
    likeable_object = params[:likeable_type].constantize.find(params[:likeable_id])
    current_like = current_user.likes.where(likeable_id: params[:likeable_id])
                               .where(likeable_type: params[:likeable_type])
    if current_like.present?
      current_like.destroy_all
      likeable_object.likes_count -= 1
    else
      @like = likeable_object.likes.new
      @like.user_id = current_user.id
      @like.save
      likeable_object.likes_count += 1
    end
    likeable_object.save
    redirect_back(fallback_location: root_path)
  end
end
