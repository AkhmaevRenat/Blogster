# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.user_id :integer
      t.references :likeable, polymorphic: true
      t.timestamps
    end
  end
end
