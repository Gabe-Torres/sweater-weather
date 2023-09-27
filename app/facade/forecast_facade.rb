class ForecastFacade

  def self.get_forecast(location)
    weather_data = ForecastService.get_forecast(location)
    Forecast.new(weather_data)
  end

  # def self.get_forecast_for_eta(location, eta)
  #   weather_data = ForecastService.get_forcast_for_eta(location, eta)
  #   Forecast_eta.new(weather_data)
  # end
end