require 'rails_helper'

describe GoogleService do
  describe 'find_representative' do
    it 'finds all representatives based on a given address' do
      expected = GoogleService.find_representatives('1551 Utica Street, Denver, CO 80204')

      expect(expected).to be_a(Hash)
      expect(expected[:officials]).to be_a(Array)
      expect(expected[:officials].first).to have_key(:name)
      expect(expected[:officials].first[:name]).to be_a(String)

      expect(expected[:officials].first[:address]).to be_a(Array)
    end
  end
end
