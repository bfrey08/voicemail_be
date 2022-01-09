require 'rails_helper'

describe 'Letters API' do  
  let(:nate) { create(:user) }
  let(:valid_attributes) do
     { 
       to_address_line1: "2110 S Broadway",
       to_address_line2: "",
       to_address_city: "Denver",
       to_address_state: "CO",
       to_address_zip: 80210,
       from_address_line1: "515 S Broadway",
       from_address_line2: "",
       from_address_city: "Denver",
       from_address_state: "CO",
       from_address_zip: 80209,
       body: "Please make Grubhub free",
       user_id: nate.id,
       to_name: "Senator Michael Bennet",
       from_name: "Nate Brown"
      }
    end
  it "can get one item by its id" do
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