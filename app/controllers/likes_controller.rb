# frozen_string_literal: true

class LikesController < ApplicationController
  def like
    like_create_command.call(
      likeable_object: likeable_object,
      user: current_user
    )
    render json: { likes_count: likeable_object.reload.likes_count }
  end

  def unlike
    like_destroy_command.call(
      likeable_object: likeable_object,
      user: current_user
    )
    render json: { likes_count: likeable_object.reload.likes_count }
  end

  private

  def likeable_object
    @likeable_object ||= params[:likeable_type].constantize.find(params[:likeable_id])
  end

  def like_create_command
    @like_create_command ||= LikeManagement::Create.new
  end

  def like_destroy_command
    @like_destroy_command ||= LikeManagement::Destroy.new
  end
end
