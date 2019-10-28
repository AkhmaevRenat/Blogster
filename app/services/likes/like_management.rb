# frozen_string_literal: true

class Likes::LikeManagement
  Result = Struct.new(:success?, :context)

  def call(likeable_type:, likeable_id:, user:)
    likeable_object = likeable_type.constantize.find(likeable_id)
    current_like = user.likes.where(likeable_id: likeable_id)
                       .where(likeable_type: likeable_type).first
    if current_like.present?
      destroy_like(current_like, likeable_object)
    else
      create_like(likeable_object, user)
    end
  end

  private

  def destroy_like(like, likeable_object)
    Like.transaction do
      like.destroy!
      likeable_object.likes_count -= 1
      likeable_object.save!
    end
  end

  def create_like(likeable_object, user)
    like = likeable_object.likes.new
    like.user_id = user.id
    # like.save!
    likeable_object.likes_count += 1
    likeable_object.save!
  end
end
