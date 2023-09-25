require 'rails_helper'

RSpec.describe 'book search', type: :request do
  context 'GET /book-search' do
    scenario 'returns books for a city', :vcr do 
      location = 'denver,co'
      quantity = 5
      get "/api/v1/book_search", params: { location: location, quantity: quantity }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      # expect(result[:data][:attributes][:destination]).to eq(location)
      # expect(result[:data][:attributes][:forecast]).to be_a(Hash)
      # expect(result[:data][:attributes][:books]).to be_an(Array)
      # expect(result[:data][:attributes][:books].count).to eq(5)
    end
  end
end
