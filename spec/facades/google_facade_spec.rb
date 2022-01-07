require 'rails_helper'

describe GoogleFacade do
  describe 'representatives' do
    it 'finds all representatives and their addresses' do
      representatives = GoogleFacade.representatives('1551 Utica Street, Denver, CO 80204')

      expect(representatives).to be_a(Array)

      representatives.each do |rep|
        expect(rep).to be_a(Representative)
        expect(rep.name).to be_a(String)
        expect(rep.address).to be_a(String)
      end
    end
  end
end