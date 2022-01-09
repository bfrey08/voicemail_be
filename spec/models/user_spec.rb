require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {should have_many :letters}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
  end
end
