require 'rails_helper'

describe 'Letters API' do  
  let(:nate) do
    User.create!(full_name: "Nate Brown",
                    street_address_1: "515 S Broadway",
                    city: "Denver",
                    state: "CO",
                    zip_code: 80209)
  end
  let(:valid_attributes) do
     { 
       to_street_address_1: "2110 S Broadway",
       to_street_address_2: "",
       to_city: "Denver",
       to_state: "CO",
       to_zip: 80210,
       from_street_address_1: "515 S Broadway",
       from_street_address_2: "",
       from_city: "Denver",
       from_state: "CO",
       from_zip: 80209,
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