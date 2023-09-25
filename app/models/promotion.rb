class Promotion < ApplicationRecord
  validates :title, presence: true, format: { with: /\A[\w\s\d]+\z/ }
  validates :product_code, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
end
