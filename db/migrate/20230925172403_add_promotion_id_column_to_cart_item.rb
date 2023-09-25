class AddPromotionIdColumnToCartItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :promotion, foreign_key: true
  end
end
