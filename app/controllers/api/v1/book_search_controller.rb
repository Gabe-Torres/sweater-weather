class Api::V1::BookSearchController < ApplicationController
  def index
    require 'pry'; binding.pry
    books = BookSearchFacade.book_search(params[:location], params[:quantity])
    forcast = ForecastFacade.get_forecast(params[:location]).current_weather
    render json: BookSearchSerializer.new(params[:location], forcast, books)
  end
end

