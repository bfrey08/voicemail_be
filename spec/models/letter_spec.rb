require 'rails_helper'

RSpec.describe Letter, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:to_name) }
    it { should validate_presence_of(:to_address_line1) }
    it { should validate_presence_of(:to_address_city) }
    it { should validate_presence_of(:to_address_state) }
    it { should validate_presence_of(:to_address_zip) }
    it { should validate_presence_of(:from_name) }
    it { should validate_presence_of(:from_address_line1) }
    it { should validate_presence_of(:from_address_city) }
    it { should validate_presence_of(:from_address_state) }
    it { should validate_presence_of(:from_address_zip) }
  end
end
