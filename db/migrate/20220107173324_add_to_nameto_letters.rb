class AddToNametoLetters < ActiveRecord::Migration[5.2]
  def change
    add_column :letters, :to_name, :string
    add_column :letters, :from_name, :string
  end
end
