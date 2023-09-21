class Product < ApplicationRecord
  validates :code, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
end
