# frozen_string_literal: true

class ChangeColumnToRetweets < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    safety_assured remove_column :retweets, :author_id
    add_column :retweets, :original_article_id, :integer
  end
end
