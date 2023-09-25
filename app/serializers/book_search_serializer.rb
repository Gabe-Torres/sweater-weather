class BookSearchSerializer
  include JSONAPI::Serializer
  attributes :id, :forecast, :location

  def initialize(location, books, forecast)
    binding.pry
    @id = nil
    @forecast = forecast(location)
    @destination = location
  end

  def forecast(location)
    weather = ForecastFacade.get_forecast(location)
    {
      summary: weather.current_weather[:text],
      temperature: weather.current_weather[:temperature],
    }
  end
end