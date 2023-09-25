class ChangeDataTypeOfPromotionFreeQuantityInPromotions < ActiveRecord::Migration[7.0]
  def change
    change_column :promotions, :promotion_free_quantity, :integer
  end
end
