require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :letters }
    it { should have_one :address }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe '#full_address' do
    it "should concatenate the user's address attributes into a single line" do
      user = create(:user)

      expect(user.full_address).to eq("#{user.address.full_address}")
    end
  end
end
