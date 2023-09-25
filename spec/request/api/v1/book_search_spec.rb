require 'rails_helper'

RSpec.describe 'book search', type: :request do
  context 'GET /book-search' do
    scenario 'returns books for a city', :vcr do 
      # get "/api/v1/book-search?location=denver,co&quantity=5"
      location = 'denver,co'
      quantity = 5
      get "/api/v1/book_search", params: { location: location, quantity: quantity }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
    end
  end
end