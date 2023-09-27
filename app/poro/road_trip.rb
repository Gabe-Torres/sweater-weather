class RoadTrip
    attr_reader :origin, :destination, :travel_time
  def initialize(origin, destination, travel_data)
    @origin = origin
    @destination = destination
    @travel_time = travel_data
  end
end