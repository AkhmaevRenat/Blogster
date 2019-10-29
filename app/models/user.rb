# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :followings
  has_many :followed_users, through: :followings
  has_many :followers, foreign_key: :followed_user_id, class_name: 'Following'
  has_many :follower_users, through: :followers, source: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def following?(user)
    followed_users.where(id: user.id).exists?
  end
end
