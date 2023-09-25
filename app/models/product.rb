class Product < ApplicationRecord
  has_many :cart_items
  validates :code, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :name, presence: true, format: { with: /\A[\w\s]+\z/ }
  validates :price, presence: true, numericality: { only_float: true }
  validates :image_url, presence: true
end
