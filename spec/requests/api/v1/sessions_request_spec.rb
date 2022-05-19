require 'rails_helper'

describe 'sessions requests' do
  describe 'POST /sessions' do
    before :each do
      @user = create(:user, password: 'password', password_confirmation: 'password')
    end

    it 'returns the user information if the password is correct' do
      login_params = {
        email: @user.email,
        password: 'password'
      }

      post '/api/v1/sessions', params: login_params

      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(attributes.count).to eq 4
      expect(attributes[:email]).to eq @user.email
      expect(attributes[:name]).to eq @user.name
    end

    it 'returns invalid credentials if the password is incorrect' do
      login_params = {
        email: @user.email,
        password: 'password1'
      }

      post '/api/v1/sessions', params: login_params

      expect(response).to have_http_status 401
      expect(response.body).to match(/Invalid Credentials/)
    end

    it 'returns invalid credentials if the email is incorrect' do
      login_params = {
        email: 1,
        password: 'password'
      }

      post '/api/v1/sessions', params: login_params

      expect(response).to have_http_status 401
      expect(response.body).to match(/Invalid Credentials/)
    end

    it 'returns invalid credentials if the password is missing' do
      login_params = {
        email: @user.email
      }

      post '/api/v1/sessions', params: login_params

      expect(response).to have_http_status 401
      expect(response.body).to match(/Invalid Credentials/)
    end
  end
end