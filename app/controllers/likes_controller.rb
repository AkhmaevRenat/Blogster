# frozen_string_literal: true

class LikesController < ApplicationController
  def like_management
    likeable_object = params[:likeable_type].constantize.find(params[:likeable_id])
    like_management_command.call(
      likeable_type: likeable_object.class.name,
      likeable_id: likeable_object.id,
      user: current_user
    )
    render json: { likes_count: likeable_object.reload.likes_count }
  end

  private

  def like_management_command
    @like_management_command ||= Likes::LikeManagement.new
  end
end
