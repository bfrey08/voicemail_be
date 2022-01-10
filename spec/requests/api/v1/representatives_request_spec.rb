require 'rails_helper'

describe 'Representatives API' do
  it 'can retrieve a list of representatives when given an address in a query param' do
    user = create(:user)
    get api_v1_user_representatives_path(user)

    representatives = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(representatives[:data]).to be_an(Array)

    representatives[:data].each do |representative|
      expect(representative[:attributes]).to have_key(:address_line1)
      expect(representative[:attributes][:address_line1]).to be_a(String)

      expect(representative[:attributes]).to have_key(:address_city)
      expect(representative[:attributes][:address_city]).to be_a(String)

      expect(representative[:attributes]).to have_key(:address_state)
      expect(representative[:attributes][:address_state]).to be_a(String)

      expect(representative[:attributes]).to have_key(:address_zip)
      expect(representative[:attributes][:address_zip]).to be_a(String)

      expect(representative[:attributes]).to have_key(:name)
      expect(representative[:attributes][:name]).to be_a(String)
    end
  end
end