class User < ApplicationRecord
  has_many :letters
  validates :email, presence: true, uniqueness: true
  # validates :frontend_id, presence: true
end
