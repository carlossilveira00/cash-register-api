class Promotion < ApplicationRecord
  validates :title, presence: true, format: { with: /\A[\w\s\d]+\z/ }
  validates :product_code, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :type, presence: true
  validates :type, inclusion: { in: %w[buy_x_get_x_free price_discount_per_quantity percentage_discount_per_quantity], message: 'must be one of type buy_x_get_x_free, price_discount_per_quantity or percentage_discount_per_quantity.' }
end
