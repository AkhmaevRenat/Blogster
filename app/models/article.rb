# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true

  def retweet_of(user, retweeted_id)
    Article.find_by(user: user, id: retweeted_id)
  end

  def retweets_count
    Article.where(retweeted_id: id).count
  end
end
