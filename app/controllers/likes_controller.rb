# frozen_string_literal: true

class LikesController < ApplicationController
  def like_management
    likeable_object = params[:likeable_type].constantize.find(params[:likeable_id])
    Likes::LikeManagementWorker.perform_async(
      params[:likeable_type],
      params[:likeable_id],
      current_user.id
    )
    render json: { likes_count: likeable_object.likes_count }
  end
end
