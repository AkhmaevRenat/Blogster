# frozen_string_literal: true

class RemoveRetweetsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :retweets
    add_column :articles, :retweeted_id, :integer
  end
end
