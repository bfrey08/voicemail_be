require 'rails_helper'

describe 'User Requests' do
  describe 'get /users/:id' do
    it 'can get a specific user' do
      user = create(:user)

      get api_v1_user_path(user)

      expect(response.status).to eq 200

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
      expect(attributes[:address_line1]).to eq user.address_line1
      expect(attributes[:address_line2]).to eq user.address_line2
      expect(attributes[:address_city]).to eq user.address_city
      expect(attributes[:address_state]).to eq user.address_state
      expect(attributes[:address_zip]).to eq user.address_zip
    end
  end

  describe 'post /users' do
    it 'creates a new user when there is no user with a matching email and returns that user' do
      user_params = {
        name: 'Bob Smith',
        email: 'test@exaple.com',
        google_id: 'asdbvb32189'
      }

      post '/api/v1/users', params: user_params

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

      post '/api/v1/users', params: {email: 'test@example.com'}

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
        address_line1: "123 test st",
        address_line2: 'apt 1',
        address_city: 'city a',
        address_state: 'xx',
        address_zip: '12345-5678'
       }

      patch "/api/v1/users/#{user.id}", params: address_params

      user.reload

      expect(user.address_line1).to eq '123 test st'
      expect(user.address_line2).to eq 'apt 1'
      expect(user.address_city).to eq 'city a'
      expect(user.address_state).to eq 'xx'
      expect(user.address_zip).to eq '12345-5678'

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
      expect(attributes[:address_line1]).to eq user.address_line1
      expect(attributes[:address_line2]).to eq user.address_line2
      expect(attributes[:address_city]).to eq user.address_city
      expect(attributes[:address_state]).to eq user.address_state
      expect(attributes[:address_zip]).to eq user.address_zip
    end
  end
end