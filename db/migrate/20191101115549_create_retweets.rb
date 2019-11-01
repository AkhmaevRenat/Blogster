# frozen_string_literal: true

class CreateRetweets < ActiveRecord::Migration[5.2]
  def change
    create_table :retweets do |t|
      t.timestamps
      t.belongs_to :article
      t.belongs_to :retweeter
      t.index %i[article_id retweeter_id], unique: true
    end
  end
end
