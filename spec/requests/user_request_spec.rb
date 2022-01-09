require 'rails_helper'

describe 'User Requests' do
  describe 'get /users/:id' do
    it 'can get a specific user' do
      user = create(:user)

      get user_path(user)

      expect(response.status).to eq 200

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
      expect(attributes[:street_address_1]).to eq user.street_address_1
      expect(attributes[:street_address_2]).to eq user.street_address_2
      expect(attributes[:city]).to eq user.city
      expect(attributes[:state]).to eq user.state
      expect(attributes[:zip_code]).to eq user.zip_code
    end
  end

  describe 'post /users' do
    it 'creates a new user when there is no user with a matching email and returns that user' do
      user_params = {
        name: 'Bob Smith',
        email: 'test@exaple.com',
        google_id: 'asdbvb32189'
      }

      post '/users', params: user_params

      expect(response).to have_http_status(:success)

      user = User.find_by(email: 'test@exaple.com')

      expect(user.email).to eq 'test@exaple.com'
      expect(user.name).to eq 'Bob Smith'
      expect(user.google_id).to eq 'asdbvb32189'

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
    end

    it 'returns the existing user if the user already exists' do
      user = create(:user, email: 'test@example.com')

      post '/users', params: {email: 'test@example.com'}

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(body[:data][:id]).to eq "#{user.id}"
      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
    end
  end

  describe 'patch /users/:id' do
    it 'can update the address of a user' do
      user = create(:user)
      address_params = {
        street_address_1: "123 test st",
        street_address_2: 'apt 1',
        city: 'city a',
        state: 'xx',
        zip_code: '12345-5678'
       }

      patch "/users/#{user.id}", params: address_params

      user.reload

      expect(user.street_address_1).to eq '123 test st'
      expect(user.street_address_2).to eq 'apt 1'
      expect(user.city).to eq 'city a'
      expect(user.state).to eq 'xx'
      expect(user.zip_code).to eq '12345-5678'

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
      expect(attributes[:street_address_1]).to eq user.street_address_1
      expect(attributes[:street_address_2]).to eq user.street_address_2
      expect(attributes[:city]).to eq user.city
      expect(attributes[:state]).to eq user.state
      expect(attributes[:zip_code]).to eq user.zip_code
    end
  end
end