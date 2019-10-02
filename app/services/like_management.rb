# frozen_string_literal: true

class LikeManagement < ApplicationService
  def initialize(likeable_type, likeable_id, user)
    @likeable_type = likeable_type
    @likeable_id = likeable_id
    @user = user
  end

  Result = Struct.new(:success?, :context)

  def call(likeable_type, likeable_id, user)
    likeable_object = likeable_type.constantize.find(likeable_id)

    return Result.new(false, error: 'Type Error') if likeable_object.present?

    like = likeable_object.likes.new

    like.user_id = user.id

    if like.save
      Result.new(true, success: 'Like added.')
    else
      Result.new(false, error: like.errors)
    end
  end
end
