class RemoveAddressFromLetters < ActiveRecord::Migration[5.2]
  def change
    remove_column :letters, :to_address_line1
    remove_column :letters, :to_address_line2
    remove_column :letters, :to_address_city
    remove_column :letters, :to_address_state
    remove_column :letters, :to_address_zip
    remove_column :letters, :from_address_line1
    remove_column :letters, :from_address_line2
    remove_column :letters, :from_address_city
    remove_column :letters, :from_address_state
    remove_column :letters, :from_address_zip
  end
end
