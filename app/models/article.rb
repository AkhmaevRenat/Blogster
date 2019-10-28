# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, uniqueness: true,
                    length: { minimum: 5 }
  validates :user_id, presence: true
  validates :user, presence: true
end
