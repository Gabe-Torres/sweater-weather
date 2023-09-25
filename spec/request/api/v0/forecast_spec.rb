require 'rails_helper'

RSpec.describe 'Forecast', type: :request do
  context 'GET /forecast' do
    scenario 'returns forecast for a city', :vcr do 
      location = 'cincinnati,oh'
      get '/api/v0/forecast', params: { location: location }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(result[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(result[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(result[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(result[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(result[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(result[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(result[:data][:attributes][:current_weather]).to have_key(:condition)
      expect(result[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:date)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:max_temp_f)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:min_temp_f)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:condition)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:icon)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
      expect(result[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
      expect(result[:data][:attributes][:hourly_weather][0]).to have_key(:time)
      expect(result[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
      expect(result[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
      expect(result[:data][:attributes][:hourly_weather][0]).to have_key(:icon)

      expect(result[:data][:attributes][:current_weather]).to_not have_key(:feels_like_c)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:temp_c)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_mph)

      expect(result[:data][:attributes][:daily_weather][0]).to_not have_key(:date_epoch)
      expect(result[:data][:attributes][:daily_weather][0]).to_not have_key(:avgtemp_c)
      expect(result[:data][:attributes][:daily_weather][0]).to_not have_key(:totalsnow_cm)

      expect(result[:data][:attributes][:hourly_weather][0]).to_not have_key(:time_epoch)
      expect(result[:data][:attributes][:hourly_weather][0]).to_not have_key(:wind_mph)
      expect(result[:data][:attributes][:hourly_weather][0]).to_not have_key(:pressure_in)
    end
  end
end
