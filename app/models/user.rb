# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :followed_users, through: :followings
  has_many :followers, foreign_key: :followed_user_id, class_name: 'Following'
  has_many :follower_users, through: :followers, source: :user
  validates :name, presence: true
  scope :retweeters, ->(article_id) { joins(:articles).where(articles: { retweeted_id: article_id }) }
  scope :liked_users, lambda { |likeable_type, likeable_id|
    joins(:likes).where(likes: { likeable_type: likeable_type, likeable_id: likeable_id })
  }

  def following?(user)
    followed_users.where(id: user.id).exists?
  end
end
