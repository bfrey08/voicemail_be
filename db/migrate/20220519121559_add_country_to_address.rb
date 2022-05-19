class AddCountryToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :address_country, :string, :default => 'US'
  end
end
