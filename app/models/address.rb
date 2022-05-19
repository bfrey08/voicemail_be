class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :to, :class_name => 'Letter', :foreign_key => 'to_id'
  has_many :from, :class_name => 'Letter', :foreign_key => 'from_id'
  validates_presence_of :address_line1
  validates_presence_of :address_city
  validates_presence_of :address_state
  validates_presence_of :address_zip

  def full_address
    "#{address_line1}, #{address_city}, #{address_state}, #{address_zip}"
  end

  def address_hash
    attributes.symbolize_keys
  end
end
