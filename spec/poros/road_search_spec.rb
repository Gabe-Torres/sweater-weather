require 'rails_helper'

RSpec.describe 'Road Search' do
  describe '#initialize', :vcr do
    it 'initializes a RoadSearch object with the correct attributes' do
      params = {
        origin: 'New York, NY',
        destination: 'Los Angeles, CA',
        }

      current_time = Time.new(2023, 9, 27, 12, 0, 0)
      allow(Time).to receive(:now).and_return(current_time)
      trip_details = RoadTripFacade.get_road_trip(params[:origin], params[:destination])

      forecast = [{ date_time: current_time, temperature: 75.0, conditions: 'Sunny' }]


      road_search = RoadSearch.new(trip_details, forecast)
      expect(road_search).to be_a(RoadSearch)
      expect(road_search.id).to eq(nil)
      expect(road_search.start_city).to eq(trip_details.origin)
      expect(road_search.end_city).to eq(trip_details.destination)
      expect(road_search.travel_time).to eq(trip_details.travel_time)
      expect(road_search.weather_at_eta[:date_time]).to eq('2023-09-29 03:02:35 AM')
      expect(road_search.weather_at_eta[:temperature]).to eq(75.0)
      expect(road_search.weather_at_eta[:conditions]).to eq('Sunny')
    end

    it 'sets travel_time to "impossible" when travel_data is nil' do
      params = {
        origin: 'New York, NY',
        destination: 'London, UK',
        travel_time: nil,
        forecasy: [],
        weather_at_eta: {}
        }

      current_time = Time.new(2023, 9, 27, 12, 0, 0)
      allow(Time).to receive(:now).and_return(current_time)
      trip_details = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      origin = 'New York, NY'
      destination = 'London, UK'
      travel_time = nil
      forecast = []

      expect(trip_details.travel_time).to eq(nil)
      expect(trip_details.origin).to eq('New York, NY')
      expect(trip_details.destination).to eq('London, UK')
      expect(forecast).to eq([])
      expect(trip_details).to be_a(RoadTrip)
  
      road_search = RoadSearch.new(trip_details, forecast)

      expect(road_search.weather_at_eta).to eq({})
    end

    # it 'can round time' do
      # params = {
      #   origin: 'New York, NY',
      #   destination: 'Los Angeles, CA',
      #   travel_time: '01:02:35',
      #   }

      # current_time = Time.new(2023, 9, 27, 12, 0, 0)
      # allow(Time).to receive(:now).and_return(current_time)
      # trip_details = RoadTripFacade.get_road_trip(params[:origin], params[:destination])

      # forecast = [{ date_time: current_time, temperature: 75.0, conditions: 'Sunny' }]


      # road_search = RoadSearch.new(trip_details, forecast)

      # expect(road_search.format_time(trip_details.travel_time)).to eq('2023-09-29 03:00:54 AM')

      # travel_time = '01:02:35'
      # rounded_time = RoadSearch.round_time(travel_time)

      # expect(rounded_time).to eq('01:00:00')
    # end
  end
end
