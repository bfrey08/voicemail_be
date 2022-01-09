class AddEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :google_id, :string
    rename_column :users, :full_name, :name
  end
end
