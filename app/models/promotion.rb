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
    when 'price_discount_per_quantity', 'percentage_discount_per_quantity'
      # Check if the promotion_free_quantity is present, if it is then add an error saying this type of promotion should not have any promotion_free_quantity.
      errors.add(:base, 'This type of promotion does not have promotion free quantity.') if promotion_free_quantity.present?
      # Check if min_quantity and discount are present, if they arent then add an error stating
      # they must be set on this type of promotions.
      errors.add(:base, 'This type of promotion must have a minimum quantity and a discount.') if !min_quantity.present? || !discount.present?
    end
  end

  def validate_buy_x_get_x_free(cart_item)
    # Calculate how many times the promotion can be applied
    times_applied = cart_item.quantity / min_quantity

    # To calculate the discounted value, we do the times_applied * min_quantity * product price. Since the other items must be free.
    expected_discounted_value = times_applied * min_quantity * cart_item.product.price
    # To calculate the promotion_free_quantity, we take how many times this promotion can be applied
    # and multiply it by how many free products we get from the promotion
    expected_promotion_free_quantity = times_applied * promotion_free_quantity

    # Check if the expected values match the cart item's values, if they do then return true, which means the promotion was applied correctly.
    expected_promotion_free_quantity == cart_item.free_quantity && expected_discounted_value == cart_item.discounted_price
  end
end
