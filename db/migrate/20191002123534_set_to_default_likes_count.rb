# frozen_string_literal: true

class SetToDefaultLikesCount < ActiveRecord::Migration[5.2]
  def self.up
    change_column :articles, :likes_count, :integer, default: 0
  end
end
