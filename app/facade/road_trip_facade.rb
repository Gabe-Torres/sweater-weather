class RoadTripFacade
  def self.get_road_trip(origin, destination)
    travel_data = RoadTripService.get_travel_time(origin, destination)
    details = RoadTrip.new(origin, destination, travel_data)
  end
end