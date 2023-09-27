require 'rails_helper'

RSpec.describe 'Road Search Facade' do
  context 'class methods' do
    context '.get_travel_time' do
      scenario 'returns a travel time object', :vcr do
        road_search = RoadTripFacade.get_road_trip('denver,co', 'pueblo,co')
        expect(road_search).to be_a(RoadTrip)
        expect(road_search.origin).to be_a(String)
        expect(road_search.destination).to be_a(String)
        expect(road_search.travel_time).to be_a(String)
      end
    end
  end
end