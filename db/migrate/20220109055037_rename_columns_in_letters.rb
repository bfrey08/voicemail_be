class RenameColumnsInLetters < ActiveRecord::Migration[5.2]
  def change
    rename_column :letters, :to_street_address_1, :to_address_line1
    rename_column :letters, :to_street_address_2, :to_address_line2
    rename_column :letters, :to_city, :to_address_city
    rename_column :letters, :to_state, :to_address_state
    rename_column :letters, :to_zip, :to_address_zip
    rename_column :letters, :from_street_address_1, :from_address_line1
    rename_column :letters, :from_street_address_2, :from_address_line2
    rename_column :letters, :from_city, :from_address_city
    rename_column :letters, :from_state, :from_address_state
    rename_column :letters, :from_zip, :from_address_zip
  end
end
