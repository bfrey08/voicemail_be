class Address < ApplicationRecord
  belongs_to :user

  def full_address
    "#{address_line1}, #{address_city}, #{address_state}, #{address_zip}"
  end
end
