require 'rails_helper'

RSpec.describe Letter, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should validate_presence_of(:body) }
  end
end
