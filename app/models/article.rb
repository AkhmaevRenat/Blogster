# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, uniqueness: true,
                    length: { minimum: 5 }
  validates :title, presence: true
  validates :user_id, presence: true
end
