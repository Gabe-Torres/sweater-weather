class MunchiesSearch
  attr_reader :id, :destination, :forecast, :restaurant

  def initialize(destination, forecast, restaurant)
    @id = nil
    @destination = destination
    @forecast = format_forecast(forecast)
    @restaurant = restaurant
  end

  def format_forecast(forecast)
    weather = forecast
    {
      summary: weather[:condition],
      temperature: weather[:temperature],
    }
  end
end