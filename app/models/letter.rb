class Letter < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  validates :to_name, presence: true
  validates :to_address_line1, presence: true
  validates :to_address_city, presence: true
  validates :to_address_state, presence: true
  validates :to_address_zip, presence: true
  validates :from_name, presence: true
  validates :from_address_line1, presence: true
  validates :from_address_city, presence: true
  validates :from_address_state, presence: true
  validates :from_address_zip, presence: true
end
