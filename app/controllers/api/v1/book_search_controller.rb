class Api::V1::BookSearchController < ApplicationController
  def index
    conn = Faraday.new(url: "https://openlibrary.org")
    response = conn.get("/search.json?q=#{params[:location]}&limit=#{params[:quantity]}")
    data = JSON.parse(response.body, symbolize_names: true)
  end
end