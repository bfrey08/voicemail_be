class RenameAddressColumnsInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :street_address_1, :address_line1
    rename_column :users, :street_address_2, :address_line2
    rename_column :users, :city, :address_city
    rename_column :users, :state, :address_state
    rename_column :users, :zip_code, :address_zip
  end
end
