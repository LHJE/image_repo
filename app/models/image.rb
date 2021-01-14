class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :keyword, presence: true
end
