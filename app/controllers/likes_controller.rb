# frozen_string_literal: true

class LikesController < ApplicationController
  def like
    like_management_command.like(
      likeable_type: likeable_object.class.name,
      likeable_id: likeable_object.id,
      user: current_user
    )
    render json: { likes_count: likeable_object.reload.likes_count }
  end

  def unlike
    like_management_command.unlike(
      likeable_type: likeable_object.class.name,
      likeable_id: likeable_object.id,
      user: current_user
    )
    render json: { likes_count: likeable_object.reload.likes_count }
  end

  private

  def likeable_object
    @likeable_object ||= params[:likeable_type].constantize.find(params[:likeable_id])
  end

  def like_management_command
    @like_management_command ||= Likes::LikeManagement.new
  end
end
