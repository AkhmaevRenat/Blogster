# frozen_string_literal: true

class AddIndexesToModel < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    add_index :articles, :user_id, algorithm: :concurrently
    add_index :comments, :user_id, algorithm: :concurrently
    add_index :users, :email, algorithm: :concurrently
    add_index :likes, :user_id, algorithm: :concurrently
    add_index :likes, %i[likeable_type likeable_id], algorithm: :concurrently
    add_index :articles, :created_at, algorithm: :concurrently
    add_index :comments, :created_at, algorithm: :concurrently
  end
end
