class User < ApplicationRecord
  has_many :letters
  validates :email, presence: true, uniqueness: true

  def full_address
    "#{address_line1}, #{address_city}, #{address_state}, #{address_zip}"
  end
end
