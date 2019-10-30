# frozen_string_literal: true

class Likes::LikeManagementWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(likeable_type, likeable_id, user_id)
    like_management_command.call(
      likeable_type: likeable_type,
      likeable_id: likeable_id,
      user: User.find(user_id)
    )
  end

  private

  def like_management_command
    @like_management_command ||= Likes::LikeManagement.new
  end
end
