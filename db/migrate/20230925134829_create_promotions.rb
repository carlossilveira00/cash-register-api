class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :product_code
      t.string :type
      t.float :discount
      t.integer :min_quantity
      t.string :promotion_free_quantity
      t.string :integer

      t.timestamps
    end
  end
end
