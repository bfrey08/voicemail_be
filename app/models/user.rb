class User < ApplicationRecord
  has_many :letters
  has_one :address, dependent: :destroy
  validates :email, presence: true, uniqueness: true

  has_secure_password(validations: false)

  def full_address
    address.full_address
  end

  def address_hash
    address.address_hash.except(:user_id, :created_at, :updated_at)
  end

  def add_address(address)
    address.add_name(user: self)
    self.address = address
  end
end
