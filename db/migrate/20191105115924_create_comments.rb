# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.references :article, foreign_key: true
      t.integer :likes_count, default: 0

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :created_at
  end
end
