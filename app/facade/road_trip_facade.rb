class RoadTripFacade
  def self.get_road_trip(origin, destination)
    # require 'pry'; binding.pry
    travel_data = RoadTripService.get_travel_time(origin, destination)
    # travel_data = travel_time[:route][:formattedTime]
    # binding.pry
    details = RoadTrip.new(origin, destination, travel_data)
    # forecast = Forecastservice.get_forecast(destination,
    # RoadTrip.new(origin, destination, travel_time, forecast)
  end
end