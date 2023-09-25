class RenameTypeColumnInPromotions < ActiveRecord::Migration[7.0]
  def change
    rename_column :promotions, :type, :promotion_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
