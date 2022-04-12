require 'rails_helper'

describe GoogleService do
  describe 'find_representative' do
    it 'finds all representatives based on a given address', :vcr do
      Rails.cache.clear
      expected = GoogleService.find_representatives('1551 Utica Street, Denver, CO 80204')

      expect(expected).to be_a(Hash)
      expect(expected).to have_key(:officials)
      expect(expected[:officials]).to be_a(Array)
      expect(expected[:officials].first).to have_key(:name)
      expect(expected[:officials].first[:name]).to be_a(String)

      expect(expected[:officials].first[:address]).to be_a(Array)

      expect(expected).to have_key(:offices)
      expect(expected[:offices]).to be_a(Array)
      expect(expected[:offices].first).to have_key(:officialIndices)
      expect(expected[:offices].first[:officialIndices]).to be_a(Array)

      expect(expected[:offices].first[:officialIndices].first).to be_a(Integer)
    end
  end
end
