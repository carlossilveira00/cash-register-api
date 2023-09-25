class RemoveIntegerColumnFromPromotions < ActiveRecord::Migration[7.0]
  def change
    remove_column :promotions, :integer
  end
end
