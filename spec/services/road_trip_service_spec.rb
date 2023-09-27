require 'rails_helper'

RSpec.describe 'Road Trip Service', :vcr do
  context 'instance methods', :vcr do
    scenario '#road trip details', :vcr do
      road_trip_service = RoadTripService.get_travel_time('denver,co', 'pueblo,co')
      conn = RoadTripService.conn

      expect(road_trip_service).to eq('01:38:37')
      expect(conn.url_prefix.to_s).to eq('https://www.mapquestapi.com/')
    end
  end
end