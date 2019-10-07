# frozen_string_literal: true

class LikesController < ApplicationController
  def add_like
    add_like_command.call(
      likeable_type: params[:likeable_type],
      likeable_id: params[:likeable_id],
      user: current_user
    )
    likeable_object = params[:likeable_type].constantize.find(params[:likeable_id])
    render json: { likes_count: likeable_object.likes_count }
  end

  private

  def add_like_command
    @add_like_command ||= LikesManagement::AddLike.new
  end
end
