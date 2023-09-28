class ChangePromotionStatusNameInCartItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :cart_items, :promotions_status, :promotion_status
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
