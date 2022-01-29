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

    it 'returns an error if the user is not found' do
      create(:user)

      get "/api/v1/users/#{User.all.last.id + 1}"

      expect(response).to have_http_status 404

      expect(response.body).to match(/Couldn't find User/)
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

    it 'can create a user with username/password instead of oauth' do
      user_params = {
        name: 'Bob Smith',
        email: 'test@exaple.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v1/users', params: user_params

      expect(response).to have_http_status(:success)

      user = User.find_by(email: 'test@exaple.com')

      expect(user.email).to eq 'test@exaple.com'
      expect(user.name).to eq 'Bob Smith'
      expect(user.authenticate('password')).to eq user

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
    end

    it 'returns the existing user if the user already exists and came from google' do
      user = create(:user, email: 'test@example.com')

      post '/api/v1/users', params: {email: 'test@example.com', google_id: 'test'}

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(body[:data][:id]).to eq "#{user.id}"
      expect(attributes.count).to eq 8
      expect(attributes[:email]).to eq user.email
      expect(attributes[:name]).to eq user.name
      expect(attributes[:google_id]).to eq user.google_id
    end

    it 'returns an error if the email has been taken and the request was not from google' do
      user_params = {
        name: 'Bob Smith',
        email: 'test@exaple.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v1/users', params: user_params

      expect(response).to have_http_status(:success)

      post '/api/v1/users', params: user_params

      expect(response.status).to eq 422
      expect(response.body).to match(/Email has already been registered/)
    end

    it 'returns an error if the user cannot be saved' do
      post '/api/v1/users', params: {}

      expect(response).to have_http_status 422

      expect(response.body).to match(/Validation failed: Email can't be blank/)
    end

    it 'returns an error if the password does not match confirmation' do
      user_params = {
        name: 'Bob Smith',
        email: 'test@exaple.com',
        password: 'password',
        password_confirmation: 'password1'
      }

      post '/api/v1/users', params: user_params

      expect(response).to have_http_status(422)

      expect(response.body).to match(/Password and confirmation do not match/)
    end
  end

  describe 'patch /users/:id' do
    it 'can update the address of a user', :vcr do
      user = create(:user)
      address_params = {
        address_line1: "8101 Ralston Rd",
        address_line2: "",
        address_city: 'Denver',
        address_state: 'CO',
        address_zip: '80002'
       }

      patch "/api/v1/users/#{user.id}", params: address_params

      user.reload

      expect(user.address_line1).to eq '8101 Ralston Rd'
      expect(user.address_line2).to eq ''
      expect(user.address_city).to eq 'Denver'
      expect(user.address_state).to eq 'CO'
      expect(user.address_zip).to eq '80002'

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

    it 'doesnt update the address if the given address is invalid', :vcr do
      user = create(:user)
      address_params = {
        address_line1: "kdcspkspzxca",
        address_line2: "vfdclps",
        address_city: 'lvcpadslvcpalspac',
        address_state: 'vk',
        address_zip: '06432'
       }

      patch "/api/v1/users/#{user.id}", params: address_params

      user.reload

      expect(user.address_line1).to_not eq 'kdcspkspzxca'
      expect(user.address_line2).to_not eq 'vfdclps'
      expect(user.address_city).to_not eq 'lvcpadslvcpalspac'
      expect(user.address_state).to_not eq 'vk'
      expect(user.address_zip).to_not eq '06432'

      body = JSON.parse(response.body, symbolize_names: true)

      message = "Address failed to pass verification; please try again."

      expect(body[:message]).to eq(message)
      expect(response.status).to eq(422)
    end

    it 'returns an error if the user is not found' do
      create(:user)

      patch "/api/v1/users/#{User.all.last.id + 1}"

      expect(response).to have_http_status 404

      expect(response.body).to match(/Couldn't find User/)
    end
  end
end
