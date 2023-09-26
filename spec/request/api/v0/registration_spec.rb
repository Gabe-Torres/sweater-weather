require 'rails_helper'

RSpec.describe 'Registration API', type: :request do
  context 'POST /registration' do
    scenario 'creates a new user' do
      valid_user = ({ 
        email: 'myemail@email.com',
        password: 'password',
        password_confirmation: 'password'
      })
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/registration', headers: headers, params: valid_user.to_json

      expect(response).to have_http_status(:created)
      expect(response.content_type).to match(a_string_including('application/json'))

      response_body = JSON.parse(response.body)
      expect(response_body['data']['type']).to eq('users')
      expect(response_body['data']['attributes']['email']).to eq(valid_user[:email])
      expect(response_body['data']['attributes']['api_key']).to be_a(String)
      expect(response_body['data']['attributes']['api_key'].length).to eq(24)
      expect(response_body['data']['attributes']['password_digest']).to be_nil
    end
  end

  context 'POST /registration sad path' do
    scenario 'returns an error passwords dont match' do
      invalid_user = ({
        email: "email@email.com",
        password: "password",
        password_confirmation: "notpassword"
      })
      header = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/registration', headers: header, params: invalid_user.to_json

      error_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(response.status).to eq(400)
      expect(error_response[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
    end
  end
end
