require 'rails_helper'

RSpec.describe Address, type: :model do
 describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of(:address_line1) }
    it { should validate_presence_of(:address_city) }
    it { should validate_presence_of(:address_state) }
    it { should validate_presence_of(:address_zip) }
  end

    describe '#full_address' do
    it "should concatenate the address attributes into a single line" do
      address = create(:address)

      expect(address.full_address).to eq("#{"#{address.address_line1}, #{address.address_city}, #{address.address_state}, #{address.address_zip}"}")
    end
  end
end
