class User < ApplicationRecord
  has_many :letters
  validates :email, presence: true, uniqueness: true
end
