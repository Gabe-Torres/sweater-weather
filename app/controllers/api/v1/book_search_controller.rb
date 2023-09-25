class Api::V1::BookSearchController < ApplicationController
  def index
    require 'pry'; binding.pry
    # render json: BookSearchFacade.book_search(params[:location], params[:quantity])
    render json: BookSearchSerializer.new(BookSearchFacade.book_search(params[:location], params[:quantity]))
  end
end