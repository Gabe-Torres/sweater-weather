class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(weather_data)
    @id = nil
    @type = 'forecast'
    @current_weather = format_current_weather(weather_data[:current]) if weather_data[:current] != nil
    @daily_weather = format_daily_weather(weather_data[:forecast][:forecastday]) if weather_data[:forecast] != nil
    @hourly_weather = format_hourly_weather(weather_data[:forecast][:forecastday][0][:hour]).take(5) if weather_data[:forecast] != nil
  end

  def format_daily_weather(daily_weather)
    daily_weather.map do |daily|
      {
        date: daily[:date].to_date.strftime("%A, %B %d, %Y"),
        max_temp_f: daily[:day][:maxtemp_f],
        min_temp_f: daily[:day][:mintemp_f],
        condition: daily[:day][:condition][:text],
        icon: daily[:day][:condition][:icon],
        sunrise: daily[:astro][:sunrise],
        sunset: daily[:astro][:sunset]
      }
    end
  end

    def format_hourly_weather(hourly_weather)
      hourly_weather.map do |hourly|
        {
          time: Time.parse(hourly[:time]).strftime("%I:%M %p"),
          temperature: hourly[:temp_f],
          conditions: hourly[:condition][:text],
          icon: hourly[:condition][:icon]
        }
      end
    end

    def format_current_weather(current_weather)
      {
        last_updated: Time.parse(current_weather[:last_updated]).strftime("%A, %B %d, %Y %I:%M %p"),
        temperature: current_weather[:temp_f],
        feels_like: current_weather[:feelslike_f],
        humidity: current_weather[:humidity],
        visibility: current_weather[:vis_miles],
        uvi: current_weather[:uv],
        condition: current_weather[:condition][:text],
        icon: current_weather[:condition][:icon]
      }
    end
end