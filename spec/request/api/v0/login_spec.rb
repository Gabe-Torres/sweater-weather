require 'rails_helper'

RSpec.describe 'sessions', type: :request do
  context 'POST /sessions' do
    scenario 'returns user api key', :vcr do 
      valid_attributes = {
        email: 'email@email.com',
        password: 'password',
        password_confirmation: 'password'
      }

      user = User.create(valid_attributes)
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/sessions', headers: headers, params: valid_attributes.to_json

      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end

  context 'POST /sessions sad path' do
    scenario 'returns an error passwords dont match' do
      invalid_attributes = {
        email: 'email@gmail.com',
        password: 'password',
        password_confirmation: 'notpassword'
      }
        user = User.create(invalid_attributes)
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v0/sessions', headers: headers, params: invalid_attributes.to_json

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        expect(error_response[:error]).to eq("Invalid credentials")
    end
  end
end