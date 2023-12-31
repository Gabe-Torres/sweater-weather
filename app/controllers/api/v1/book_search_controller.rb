class Api::V1::BookSearchController < ApplicationController
  def index
    books = BookSearchFacade.book_search(params[:location], params[:quantity])
    forecast = ForecastFacade.get_forecast(params[:location]).current_weather
    book_search = BookSearch.new(params[:location], forecast, books)
    render json: BookSearchSerializer.new(book_search).to_json, status: :ok
  end
end
