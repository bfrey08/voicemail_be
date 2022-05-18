class AddAddressIdsToLetters < ActiveRecord::Migration[5.2]
  def change
    add_reference :letters, :to, foreign_key: { to_table: 'addresses' }
    add_reference :letters, :from, foreign_key: { to_table: 'addresses' }

    # add_foreign_key :letters, :addresses, column: :to_id, primary_key: :id
    # add_foreign_key :letters, :addresses, column: :from_id, primary_key: :id
  end
end

