class AddPreviewUrLtoLetters < ActiveRecord::Migration[5.2]
  def change
    add_column :letters, :preview_url, :string
  end
end
