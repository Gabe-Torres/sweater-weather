class Api::V0::RoadTripController < ApplicationController
  def create
    trip_details
    unless verify_user || params[:api_key].nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    else
    render json: RoadTripSerializer.new(trip_details).to_json, status: :ok
    end
  end

  private 
    def verify_user
      user = User.find_by(api_key: params[:api_key])
    end

  def trip_details
    trip_details = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
    forecast = ForecastFacade.get_forecast(params[:destination]).hourly_weather
    lets_ride = RoadSearch.new(trip_details, forecast)
  end
end