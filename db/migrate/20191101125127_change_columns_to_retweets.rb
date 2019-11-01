# frozen_string_literal: true

class ChangeColumnsToRetweets < ActiveRecord::Migration[5.2]
  def change
    add_column :retweets, :new_article_id, :integer
  end
end
