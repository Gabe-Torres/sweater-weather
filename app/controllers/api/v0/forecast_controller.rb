class Api::V0::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(ForecastFacade.get_forecast(params[:location]))
  rescue ActiveRecord::RecordInvalid
    render json: ErrorForecast.new('Please provide a location'), status: :bad_request
  end
end
