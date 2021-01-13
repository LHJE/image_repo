class Image < ApplicationRecord
  belongs_to :user

  validates :keyword, presence: true
  validates :url, presence: true
end
