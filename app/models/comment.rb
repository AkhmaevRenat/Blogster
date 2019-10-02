# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  validates :body, presence: true
end
