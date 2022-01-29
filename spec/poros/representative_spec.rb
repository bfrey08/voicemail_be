require 'rails_helper'

describe Representative do
  describe 'attributes' do
    it 'can create a representative successfully' do
      rep = Representative.new({ name: 'John W. Hickenlooper',
                                 address: [
                                   {
                                     "line1": 'B85',
                                     "city": 'Washington',
                                     "state": 'DC',
                                     "zip": '20510'
                                   }
                                 ] })

      expect(rep.name).to eq('John W. Hickenlooper')

      expect(rep.address_line1).to eq('B85')
      expect(rep.address_city).to eq('Washington')
      expect(rep.address_state).to eq('DC')
      expect(rep.address_zip).to eq('20510')
    end

    it 'can format addresses that are formatted differently' do
      rep = Representative.new({geocodingSummaries: [{queryString: '123 test st, Washington, DC 20515'}]})

      expect(rep.address_line1).to eq '123 test st'
      expect(rep.address_city).to eq 'Washington'
      expect(rep.address_state).to eq 'DC'
      expect(rep.address_zip).to eq '20515'
    end

    it 'can format P.O. boxes' do
      rep = Representative.new({geocodingSummaries: [{queryString: 'P.O. Box 12345, Washington, DC 20515'}]})

      expect(rep.address_line1).to eq 'P.O. Box 12345'
      expect(rep.address_city).to eq 'Washington'
      expect(rep.address_state).to eq 'DC'
      expect(rep.address_zip).to eq '20515'
    end

    it 'can format P.O. boxes that are formatted differently' do
      rep = Representative.new({geocodingSummaries: [{queryString: 'P.O. Box 12345 Washington, DC 20515'}]})

      expect(rep.address_line1).to eq 'P.O. Box 12345'
      expect(rep.address_city).to eq 'Washington'
      expect(rep.address_state).to eq 'DC'
      expect(rep.address_zip).to eq '20515'
    end
  end
end
