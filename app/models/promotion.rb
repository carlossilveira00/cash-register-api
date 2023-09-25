class Promotion < ApplicationRecord
  validates :title, presence: true, format: { with: /\A[\w\s\d]+\z/ }
  validates :product_code, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :promotion_type, presence: true
  validates :promotion_type, inclusion: { in: %w[buy_x_get_x_free price_discount_per_quantity percentage_discount_per_quantity], message: 'must be one of type buy_x_get_x_free, price_discount_per_quantity or percentage_discount_per_quantity.' }
  validate :validate_promotion_rules

  def validate_promotion_rules
    case promotion_type
    when 'buy_x_get_x_free'
      # Check if the discount is present, if it is then add an error saying this type of promotion should not have any discount.
      errors.add(:base, 'This type of promotion does not have discount.') if discount.present?
      # Check if min_quantity and promotion_free_quantity are present, if they arent then add an error stating
      # they must be set on this type of promotions.
      errors.add(:base, 'This type of promotion must have a minimum quantity and a promotion free quantity.') if !min_quantity.present? || !promotion_free_quantity.present?
    end
  end
end
