class User < ApplicationRecord
  has_many :letters
  # validates :frontend_id, presence: true
end
