class MunchiesSerializer 
  include JSONAPI::Serializer
  set_type :munchie 
  attributes :destination, :forecast, :restaurant
end