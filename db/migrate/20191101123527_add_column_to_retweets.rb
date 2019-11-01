# frozen_string_literal: true

class AddColumnToRetweets < ActiveRecord::Migration[5.2]
  def change
    add_column :retweets, :author_id, :integer
  end
end
