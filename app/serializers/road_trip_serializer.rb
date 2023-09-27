class RoadTripSerializer
  include JSONAPI::Serializer
  set_type :road_trip
  attributes :start_city, :end_city, :travel_time, :forecast, :date_time
end