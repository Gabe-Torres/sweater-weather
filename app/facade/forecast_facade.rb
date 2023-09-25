class ForecastFacade

  def self.get_forecast(location)
    weather_data = ForecastService.get_forecast(location)
    Forecast.new(weather_data)
  end
end