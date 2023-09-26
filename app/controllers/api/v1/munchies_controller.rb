class Api::V1::MunchiesController < ApplicationController
  def index
    restaurant  = MunchiesFacade.get_food(params[:destination], params[:food])
    forecast = ForecastFacade.get_forecast(params[:destination]).current_weather
    munchies_search = MunchiesSearch.new(params[:destination], forecast, restaurant)
    # require 'pry'; binding.pry
    render json: MunchiesSerializer.new(munchies_search).to_json, status: :ok
  end
end