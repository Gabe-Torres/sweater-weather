class RoadTrip
    attr_reader :origin, :destination, :travel_time
  def initialize(origin, destination, travel_data)
    # binding.pry
    @origin = origin
    @destination = destination
    @travel_time = travel_data
    # @arrival_forecast = arrival_forecast
  end
end