# frozen_string_literal: true

class Likes::LikeManagement
  Result = Struct.new(:success?, :context)

  def like(likeable_type:, likeable_id:, user:)
    likeable_object = likeable_type.constantize.find(likeable_id)
    create_like(likeable_object, user)
  end

  def unlike(likeable_type:, likeable_id:, user:)
    likeable_object = likeable_type.constantize.find(likeable_id)
    current_like = user.likes.where(likeable_id: likeable_id, likeable_type: likeable_type).first
    destroy_like(current_like, likeable_object)
  end

  private

  def destroy_like(like, likeable_object)
    if like.nil?
      Result.new(false, "Like already removed or didn't exist")
    else
      Like.transaction do
        like.destroy!
        likeable_object.increment!(:likes_count, -1)
      end
      Result.new(true, 'Like removed successfully')
    end
  end

  def create_like(likeable_object, user)
    if likeable_object.likes.where(user: user).empty?
      Like.transaction do
        like = likeable_object.likes.new
        like.user_id = user.id
        like.save!
        likeable_object.increment(:likes_count, 1)
        likeable_object.save!
      end
      Result.new(true, 'Like added')
    else
      Result.new(false, 'Error: like already exists')
    end
  end
end
