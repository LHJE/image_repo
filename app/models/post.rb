class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :keyword, presence: true
  # validate :image_type

  private

  # def image_type
  #   if image.attached? == false
  #     errors.add(:image, 'art missing!')
  #   end
  #   if !image.content_type.in?(%('image/jpeg image/png'))
  #     errors.add(:image, 'needs to be a JPEG or PNG')
  #   end
  # end
end
