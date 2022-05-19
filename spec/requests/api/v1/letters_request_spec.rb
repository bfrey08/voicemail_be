require 'rails_helper'

describe 'Letters API' do
  let(:nate) { create(:user) }
  let(:valid_attributes) do
    {
      to_address_line1: '2110 S Broadway',
      to_address_line2: '',
      to_address_city: 'Denver',
      to_address_state: 'CO',
      to_address_zip: '80210',
      from_address_line1: '515 S Broadway',
      from_address_line2: '',
      from_address_city: 'Denver',
      from_address_state: 'CO',
      from_address_zip: '80209',
      body: 'Please make Grubhub free',
      user_id: nate.id,
      to_name: 'Senator Michael Bennet',
      from_name: 'Nate Brown'
    }
  end

  context 'when valid attributes entered' do
    it 'can create a letter', :vcr do
      post '/api/v1/letters', params: valid_attributes

      confirmation = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful

      expect(confirmation[:data]).to have_key(:id)
      expect(confirmation[:data][:id]).to be_a(String)

      expect(confirmation[:data][:attributes]).to have_key(:to_name)
      expect(confirmation[:data][:attributes][:to_name]).to be_a(String)

      expect(confirmation[:data][:attributes][:send_date]).to be nil
      expect(confirmation[:data][:attributes][:delivery_date]).to be nil
      expect(confirmation[:data][:attributes][:preview_url]).to be nil
    end
  end

  context 'when required attributes are missing' do
    it 'errors out and does not create a letter' do
      valid_attributes.delete(:body)
      valid_attributes.delete(:to_name)
      valid_attributes.delete(:from_name)
      invalid_attributes = valid_attributes
      post '/api/v1/letters', params: invalid_attributes

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful

      expect(confirmation).to have_key(:message)
      expect(confirmation[:message]).to eq('Your letter could not be sent.')

      expect(confirmation[:errors]).to include("Body can't be blank")
      expect(confirmation[:errors]).to include("To name can't be blank")
      expect(confirmation[:errors]).to include("From name can't be blank")
    end
  end

  context 'when letter id is valid' do
    it 'can delete a letter from database' do
      letter = create(:letter)

      expect(Letter.count).to eq(1)

      delete api_v1_letter_path(letter)

      expect(response).to be_successful

      expect(Letter.count).to eq(0)
    end
  end

  context 'when letter id is invalid' do
    it 'errors out' do
      letter = create(:letter)

      expect(Letter.count).to eq(1)

      delete '/api/v1/letters/invalid_id'

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful

      expect(Letter.count).to eq(1)
      expect(confirmation[:error]).to eq("Couldn't find Letter with 'id'=invalid_id")
    end
  end

  context "when valid user's id is used" do
    it 'can retrieve a users letters (index)' do
      user = create(:user)
      create_list(:letter, 5, user: user)

      get api_v1_user_letters_path(user)

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(confirmation).to have_key(:data)
      expect(confirmation[:data].length).to eq(5)

      expect(confirmation[:data].first[:attributes]).to have_key(:body)
      expect(confirmation[:data].first[:attributes][:body]).to be_a(String)
    end
  end

  context "when invalid user's id is used" do
    it 'errors out' do
      user = create(:user)
      create_list(:letter, 5, user: user)

      get '/api/v1/users/invalid_id/letters'

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful

      expect(confirmation[:message]).to eq('Letters not found')
      expect(confirmation[:errors]).to include('No letters with that user id could be found. Check that you entered it correctly')
    end
  end

  context "when valid user's id is used" do
    it "can send a letter based on a user's id", :vcr do
        post '/api/v1/letters', params: valid_attributes
        post "/api/v1/letters/send", params: {email: nate.email}

        confirmation = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(confirmation[:data][:attributes][:send_date]).not_to be nil
        expect(confirmation[:data][:attributes][:delivery_date]).not_to be nil
        expect(confirmation[:data][:attributes][:preview_url]).not_to be nil
    end
  end

  context "when valid data is used for preview letter" do
    it "can fetch a PDF preview URL", :vcr do
        post '/api/v1/letters/preview', params: valid_attributes

        preview_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(preview_data[:data][:attributes][:send_date]).not_to be nil
        expect(preview_data[:data][:attributes][:delivery_date]).not_to be nil
        expect(preview_data[:data][:attributes][:preview_url]).to include("https://lob-assets.com/letters/")
    end
  end

  context "when to address is missing for preview letter" do
    it "errors out", :vcr do
        valid_attributes.delete(:to_address_line1)
        valid_attributes.delete(:to_address_city)

        post '/api/v1/letters/preview', params: valid_attributes

        expect(response).not_to be_successful

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:data]).to be nil
        expect(error[:error]).to eq("Validation failed: Address line1 can't be blank, Address city can't be blank")
    end
  end


end
