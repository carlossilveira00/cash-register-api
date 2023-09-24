class AddFreeQuantityToCartItem < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :free_quantity, :integer
  end
end
