# frozen_string_literal: true

class AddLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.references :likeable, polymorphic: true
      t.timestamps
    end
  end
end
