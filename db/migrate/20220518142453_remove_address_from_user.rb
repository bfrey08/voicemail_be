class RemoveAddressFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :address_line1
    remove_column :users, :address_line2
    remove_column :users, :address_city
    remove_column :users, :address_state
    remove_column :users, :address_zip
  end
end
