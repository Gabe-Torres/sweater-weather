class Api::V0::RoadTripController < ApplicationController
  def create
    binding.pry
    trip_details = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
    forecast = ForecastFacade.get_forecast(params[:destination]).hourly_weather
    lets_ride = RoadSearch.new(trip_details, forecast)
    render json: RoadTripSerializer.new(lets_ride).to_json, status: :ok
  end
end