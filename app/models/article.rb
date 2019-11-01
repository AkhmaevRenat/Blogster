# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5 }
  validates :user, presence: true

  def retweet(article, user)
    @article = article
    @user = user
    Article.where(user: @user).find_by(retweeted_id: @article.id)
  end
end
