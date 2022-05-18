class Letter < ApplicationRecord
  belongs_to :user
  belongs_to :to, :class_name => 'Address'
  belongs_to :from, :class_name => 'Address'
  validates :body, presence: true
  validates :to_name, presence: true
  validates :from_name, presence: true
  
end
