class AddDeliveryDateToLetters < ActiveRecord::Migration[5.2]
  def change
    add_column :letters, :delivery_date, :string
    add_column :letters, :send_date, :string
  end
end
