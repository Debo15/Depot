class Product < ApplicationRecord
  validates :name, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|png|jpg|webp)\z},
    message: "must be a URL for gif, png, jpg or webp image"
  }
end
