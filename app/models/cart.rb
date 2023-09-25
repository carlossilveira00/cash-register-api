class Cart < ApplicationRecord
  has_many :cart_items

  def validate_total_price
    cart_items = CartItem.where(cart_id: id)
    # If discounted_price is nil, means no discount was applied, so we sum the undiscounted_price.
    expected_price = cart_items.sum { |item| item.discounted_price || item.undiscounted_price }

    expected_price == total
  end
end
