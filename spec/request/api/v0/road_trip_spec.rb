require "rails_helper"

RSpec.describe "Road Trip" do
  context "can get road trip information", type: :request do
    context "POST /road_trip" do
      scenario "successful response", :vcr do
        valid_road_trip_attributes = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: "jgn983hy48thw9begh98h4539h4"
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/road_trip", headers: headers, params: valid_road_trip_attributes.to_json

        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end