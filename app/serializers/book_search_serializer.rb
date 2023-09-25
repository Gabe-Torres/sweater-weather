class BookSearchSerializer
  include JSONAPI::Serializer
  attributes :id, :type, :books, :forecast

  def initialize(location)
    @destination = location
  end 

  def forecast(location)
    weather = ForecastFacade.get_forecast(location)

    {
      summary: weather.current_weather[:summary],
      temperature: weather.current_weather[:temperature],
    }
  end
end