class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :to, :class_name => 'Letter', :foreign_key => 'to_id'
  has_many :from, :class_name => 'Letter', :foreign_key => 'from_id'

  def full_address
    "#{address_line1}, #{address_city}, #{address_state}, #{address_zip}"
  end

  def address_hash
    attributes.symbolize_keys
  end
end
