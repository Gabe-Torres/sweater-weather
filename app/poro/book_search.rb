class BookSearch 
  attr_reader :id, :destination, :forecast, :total_books_found, :books
  def initialize(destination, forecast, books)
    @id = nil
    @destination = destination
    @forecast = format_forecast(forecast)
    @total_books_found = books.count
    @books = books
  end

  def format_forecast(forecast)
    weather = forecast
    {
      summary: weather[:condition],
      temperature: weather[:temperature],
    }
  end
end