class CreateLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :letters do |t|
      t.string :to_street_address_1
      t.string :to_street_address_2
      t.string :to_city
      t.string :to_state
      t.string :to_zip
      t.string :from_street_address_1
      t.string :from_street_address_2
      t.string :from_city
      t.string :from_state
      t.string :from_zip
      t.string :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
