class Promotion < ApplicationRecord
  validates :title, presence: true, format: { with: /\A[\w\s\d]+\z/ }
end
