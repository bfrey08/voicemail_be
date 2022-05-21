class AddAddressIdsToLetters < ActiveRecord::Migration[5.2]
  def change
    add_reference :letters, :to, foreign_key: { to_table: 'addresses' }
    add_reference :letters, :from, foreign_key: { to_table: 'addresses' }
  end
end

