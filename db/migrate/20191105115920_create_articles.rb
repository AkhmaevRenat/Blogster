# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :text
      t.integer :likes_count, default: 0
      t.integer :retweeted_id

      t.timestamps
    end

    add_index :articles, :user_id
    add_index :articles, :created_at
  end
end
