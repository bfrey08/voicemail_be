require 'rails_helper'

describe 'Letters API' do
  let(:nate) { User.create!(name: 'Nate', 
                           email: 'nate@gmail.com',
                       google_id: 'blah') }
  let(:valid_attributes) do
    {
      address_line1: '2110 S Broadway',
      address_line2: '',
      address_city: 'Denver',
      address_state: 'CO',
      address_zip: '80210',
      user_id: nate.id,
    }
  end

  context 'when valid attributes entered' do
    it 'can create a address' do
      post '/api/v1/addresses', params: valid_attributes

      confirmation = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(confirmation[:data]).to have_key(:id)
      expect(confirmation[:data][:id]).to be_a(String)

      expect(confirmation[:data][:attributes]).to have_key(:user_id)
      expect(confirmation[:data][:attributes][:user_id]).to be_a(Integer)

      expect(confirmation[:data][:attributes]).to have_key(:address_line1)
      expect(confirmation[:data][:attributes][:address_line1]).to be_a(String)

      expect(confirmation[:data][:attributes]).to have_key(:address_line2)
      expect(confirmation[:data][:attributes][:address_line2]).to be_a(String)

      expect(confirmation[:data][:attributes]).to have_key(:address_city)
      expect(confirmation[:data][:attributes][:address_city]).to be_a(String)

      expect(confirmation[:data][:attributes]).to have_key(:address_state)
      expect(confirmation[:data][:attributes][:address_state]).to be_a(String)

      expect(confirmation[:data][:attributes]).to have_key(:address_zip)
      expect(confirmation[:data][:attributes][:address_zip]).to be_a(String)
    end
  end


  context 'when required attributes are missing' do
    it 'errors out and does not create an address' do
      valid_attributes.delete(:address_line1)
      valid_attributes.delete(:address_city)
      
      invalid_attributes = valid_attributes
      post '/api/v1/addresses', params: invalid_attributes

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful

      expect(confirmation[:error]).to eq("Validation failed: Address line1 can't be blank, Address city can't be blank")
    end
  end

  context 'when address id is valid' do
    it 'can delete a address from database' do
      address = create(:address)

      expect(Address.count).to eq(1)

      delete api_v1_address_path(address)

      expect(response).to be_successful

      expect(Address.count).to eq(0)
    end
  end

  context 'when address id is invalid' do
    it 'errors out' do
      create(:address)

      expect(Address.count).to eq(1)

      delete '/api/v1/addresses/invalid_id'

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful

      expect(Address.count).to eq(1)
      expect(confirmation[:error]).to eq("Couldn't find Address with 'id'=invalid_id")
    end
  end
end