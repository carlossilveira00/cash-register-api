class AddPromotionStatusToCartItem < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :promotions_status, :string
  end
end
