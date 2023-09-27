class RoadSearch
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta
  def initialize(trip_details, forecast)
    @id = nil
    @start_city = trip_details.origin
    @end_city = trip_details.destination
    @travel_time = trip_details.travel_time.nil? ? "impossible" : trip_details.travel_time
    @weather_at_eta = format_forcast(forecast).nil? ? {} : format_forcast(forecast)
    @date_time = format_time(trip_details.travel_time)
  end

  def format_forcast(forecast)
    unless @travel_time == "impossible"
    weather = forecast.first
    { 
      date_time: format_time(travel_time),
      temperature: weather[:temperature],
      conditions: weather[:conditions],
    }
    end
  end
  
  # def round_time(travel_time)
  #   time = Time.parse(travel_time)

  #   round_time = Time.at((time.to_f / 3600).round * 3600)

  #   new_time = round_time.strftime("%H:00:00")
  # end

  def format_time(travel_time)
    unless @travel_time == "impossible"
    hours, minutes, seconds = travel_time.split(':').map(&:to_i)

    travel_time_seconds = (hours * 3600) + (minutes * 60) + seconds

    current_time = Time.now

    arrival_time = current_time + travel_time_seconds

    final_time = arrival_time.strftime("%Y-%m-%d %I:%M:%S %p")
    end
  end
end
