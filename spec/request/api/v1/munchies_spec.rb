require "rails_helper"

RSpec.describe "Yelp API", type: :request do
  context "GET /api/v1/munchies" do
    scenario "returns a list of restaurants" do
      destination = "denver,co" 
      food = "italian"

      get "/api/v1/munchies", params: {destination: destination, food: food}

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
    end
  end
end