require 'rails_helper'

RSpec.describe "Road Trip Poro" do
  describe '#format_road_trip' do
    it 'formats the road trip data correctly' do
      origin = 'New York, NY'
      destination = 'Los Angeles, CA'
      travel_time = '40 hours'

      road_trip = RoadTrip.new(origin, destination, travel_time)

      expect(road_trip.origin).to eq('New York, NY')
      expect(road_trip.destination).to eq('Los Angeles, CA')
      expect(road_trip.travel_time).to eq('40 hours')
    end
  end
end