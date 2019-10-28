class SetToDefaultCommentsLikesCount < ActiveRecord::Migration[5.2]
  def self.up
    change_column :comments, :likes_count, :integer, default: 0
  end
end
