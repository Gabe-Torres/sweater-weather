class Api::V1::BookSearchController < ApplicationController
  def index
    # conn = Faraday.new(url: "https://openlibrary.org")
    # require 'pry'; binding.pry
    # response = conn.get("/search.json?q=#{params[:location]}&limit=#{params[:quantity]}")
    # data = JSON.parse(response.body, symbolize_names: true)
    render json: BookSearchSerializer.new(BookSearchFacade.book_search(params[:location], params[:quantity]))
  end
end