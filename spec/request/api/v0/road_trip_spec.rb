require "rails_helper"

RSpec.describe "Road Trip" do
  context "can get road trip information", type: :request do
    context "POST /road_trip" do
      scenario "successful response", :vcr do
        user = User.create!(email: 'email@emai.com', password: 'password', password_confirmation: 'password')
        valid_road_trip_attributes = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: user.api_key
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/road_trip", headers: headers, params: valid_road_trip_attributes.to_json

        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.status).to eq(200)
        expect(response.body).to be_a(String)
        expect(response.body).to include("data")
        expect(response.body).to include("type")
        expect(response.body).to include("id")
        expect(response.body).to include("attributes")
        expect(response.body).to include("start_city")
        expect(response.body).to include("end_city")
        expect(response.body).to include("travel_time")
        expect(response.body).to include("weather_at_eta")
        expect(response.body).to include("temperature")
        expect(response.body).to include("conditions")
        expect(response.body).to include("date_time")
      end
    end

    context "POST /road_trip sad path" do
      scenario "unsuccessful response", :vcr do
        user = User.create!(email: 'email@emai.com', password: 'password', password_confirmation: 'password')
        invalid_road_trip_attributes = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: "invalid"
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/road_trip", headers: headers, params: invalid_road_trip_attributes.to_json

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to_not be_successful
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.status).to eq(401)
        expect(error_response).to be_a(Hash)
        expect(error_response).to have_key(:error)
        expect(error_response[:error]).to eq("Unauthorized")
        expect(error_response).to_not have_key(:data)
      end
    end

    context "POST /road_trip cant get there" do
      scenario "returns impossible", :vcr do
        user = User.create!(email: 'email@emai.com', password: 'password', password_confirmation: 'password')
        road_trip_attributes = {
          origin: "New York,NY",
          destination: "London,UK",
          api_key: user.api_key
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/road_trip", headers: headers, params: road_trip_attributes.to_json

        

        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.status).to eq(200)
        expect(response.body).to be_a(String)
        expect(response.body).to include("data")
        expect(response.body).to include("type")
        expect(response.body).to include("id")
        expect(response.body).to include("attributes")
        expect(response.body).to include("start_city")
        expect(response.body).to include("end_city")
        expect(response.body).to include("travel_time")
        expect(response.body).to include("weather_at_eta")
        expect(response.body).to include("impossible")
      end
    end
  end
end