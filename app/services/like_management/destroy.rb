# frozen_string_literal: true

class LikeManagement::Destroy
  Result = Struct.new(:success?, :context)

  def call(likeable_object:, user:)
    current_like = likeable_object.likes.find_by(user_id: user.id)
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
end
