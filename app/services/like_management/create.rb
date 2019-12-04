# frozen_string_literal: true

class LikeManagement::Create
  Result = Struct.new(:success?, :context)

  def call(likeable_object:, user:)
    create_like(likeable_object, user)
  end

  private

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
