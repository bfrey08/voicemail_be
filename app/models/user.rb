class User < ApplicationRecord
  has_many :letters
  validates :email, presence: true, uniqueness: true

  has_secure_password(validations: false)

  def full_address
      "#{self.address_line1}, #{self.address_city}, #{self.address_state}, #{self.address_zip}"
  end
end
