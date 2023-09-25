require 'rails_helper'

RSpec.describe 'Members Facade' do
  context 'instance methods', :vcr do
    scenario '#get_forecast' do
      forcast = ForecastFacade.get_forecast('cincinnati,oh')

      forcast.current_weather.each do |key, value|
        expect(key).to eq(:last_updated).or eq(:temperature)
                                        .or eq(:feels_like)
                                        .or eq(:humidity)
                                        .or eq(:visibility)
                                        .or eq(:uvi)
                                        .or eq(:condition)
                                        .or eq(:icon)
        expect(value).to be_a(String).or be_a(Float).or be_a(Integer)
        expect(value).to_not be_a(Hash)
      end

      forcast.daily_weather.each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
      end

      forcast.hourly_weather.each do |hour|
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
  
      end
    end
  end
end