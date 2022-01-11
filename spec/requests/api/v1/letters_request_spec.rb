require 'rails_helper'

describe 'Letters API' do  
  let(:nate) { create(:user) }
  let(:valid_attributes) do
     { 
       to_address_line1: "2110 S Broadway",
       to_address_line2: "",
       to_address_city: "Denver",
       to_address_state: "CO",
       to_address_zip: "80210",
       from_address_line1: "515 S Broadway",
       from_address_line2: "",
       from_address_city: "Denver",
       from_address_state: "CO",
       from_address_zip: "80209",
       body: "Please make Grubhub free",
       user_id: nate.id,
       to_name: "Senator Michael Bennet",
       from_name: "Nate Brown"
      }
    end
  context 'when valid attributes entered' do
    it "can create a letter", :vcr do
        post "/api/v1/letters", params: valid_attributes

        confirmation = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(confirmation[:data]).to have_key(:id)
        expect(confirmation[:data][:id]).to be_a(String)

        expect(confirmation[:data][:attributes]).to have_key(:to_name)
        expect(confirmation[:data][:attributes][:to_name]).to be_a(String)


        expect(confirmation[:data][:attributes]).to have_key(:send_date)
        expect(confirmation[:data][:attributes][:send_date]).to be_a(String)

        expect(confirmation[:data][:attributes]).to have_key(:delivery_date)
        expect(confirmation[:data][:attributes][:delivery_date]).to be_a(String)
    end
  end
  context 'when required attributes are missing' do
    it "errors out" do
      valid_attributes.delete(:body)
      valid_attributes.delete(:to_name)
      valid_attributes.delete(:from_name)
      invalid_attributes = valid_attributes
      post "/api/v1/letters", params: invalid_attributes

      confirmation = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      
      
      expect(confirmation).to have_key(:message)
      expect(confirmation[:message]).to eq("Your letter could not be sent.")

      expect(confirmation[:errors]).to include("Body can't be blank")
      expect(confirmation[:errors]).to include("To name can't be blank")
      expect(confirmation[:errors]).to include("From name can't be blank")
    end
  end
end