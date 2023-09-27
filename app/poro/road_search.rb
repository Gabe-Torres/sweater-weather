class RoadSearch
  attr_reader :id, :start_city, :end_city, :travel_time, :forecast, :date_time
  def initialize(trip_details, forecast)
    @id = nil
    @start_city = trip_details.origin
    @end_city = trip_details.destination
    @travel_time = trip_details.travel_time
    @forecast = format_forcast(forecast)
    @date_time = date_time(trip_details.travel_time)
  end

  def format_forcast(forecast)
    weather = forecast.first
    { 
      conditions: weather[:conditions],
      temperature: weather[:temperature],
    }
  end
  
  def round_time(travel_time)
    time = Time.parse(travel_time)

    round_time = Time.at((time.to_f / 3600).round * 3600)

    new_time = round_time.strftime("%H:00:00")
  end

  def date_time(travel_time)
    hours, minutes, seconds = travel_time.split(':').map(&:to_i)

    travel_time_seconds = (hours * 3600) + (minutes * 60) + seconds

    current_time = Time.now

    arrival_time = current_time + travel_time_seconds

    final_time = arrival_time.strftime("%Y-%m-%d %I:%M:%S %p")
  end
end
