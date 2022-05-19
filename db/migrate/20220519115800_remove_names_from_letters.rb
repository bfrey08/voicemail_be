class RemoveNamesFromLetters < ActiveRecord::Migration[5.2]
  def change
    remove_column :letters, :to_name
    remove_column :letters, :from_name
  end
end
