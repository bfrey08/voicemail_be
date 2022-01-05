require 'rails_helper'

describe Representative do
  describe 'get_address' do
    it 'can convert an array of hashes into a string' do
      rep = Representative.new({name: "John W. Hickenlooper",
      address: [
        {
          "line1": "B85",
          "city": "Washington",
          "state": "DC",
          "zip": "20510"
        }
      ]})

      expect(rep.name).to eq('John W. Hickenlooper')

      expect(rep.address).to eq('B85, Washington, DC, 20510')
    end
  end
end
