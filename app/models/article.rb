class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: true,
                    length: { minimum: 5 }
  validates :user_id, presence: true
  belongs_to :user
end
