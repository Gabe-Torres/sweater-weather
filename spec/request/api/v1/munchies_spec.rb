require "rails_helper"

RSpec.describe "Yelp API", type: :request do
  context "GET /api/v1/munchies" do
    scenario "returns a list of restaurants", :vcr do
      destination = "denver,co" 
      food = "italian"

      get "/api/v1/munchies", params: {destination: destination, food: food}

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result[:data][:attributes][:destination_city]).to eq(destination)
      expect(result[:data][:attributes][:forecast]).to be_a(Hash)
      expect(result[:data][:attributes][:restaurant]).to be_a(Array)
      expect(result[:data][:attributes][:restaurant].first).to be_a(Hash)
      expect(result[:data][:attributes][:restaurant].first).to have_key(:name)
      expect(result[:data][:attributes][:restaurant].first).to have_key(:address)
    end
  end
end