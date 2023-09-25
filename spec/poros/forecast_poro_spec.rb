require "rails_helper"

RSpec.describe "Forecast Poro" do
  describe '#format_current_weather' do
    it 'formats the current weather data correctly' do
      current =  {
        "last_updated": "2023-09-24 20:45",
        "temp_f": 73.9,
        "condition": {
            "text": "Overcast",
            "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png"
        },
        "humidity": 60,
        "feelslike_f": 77.2,
        "vis_miles": 9.0,
        "uv": 1.0
    }

      forecast = Forecast.new({})
      formatted_weather = forecast.format_current_weather(current)

      expect(formatted_weather[:last_updated]).to eq('Sunday, September 24, 2023 08:45 PM')
      expect(formatted_weather[:temperature]).to eq(73.9)
      expect(formatted_weather[:feels_like]).to eq(77.2)
      expect(formatted_weather[:humidity]).to eq(60)
      expect(formatted_weather[:visibility]).to eq(9.0)
      expect(formatted_weather[:uvi]).to eq(1.0)
      expect(formatted_weather[:condition]).to eq('Overcast')
      expect(formatted_weather[:icon]).to eq('//cdn.weatherapi.com/weather/64x64/night/122.png')

      daily = {
        "date": "2023-09-24",
        "day": {
            "maxtemp_f": 83.5,
            "mintemp_f": 57.0,
            "totalsnow_cm": 0.0,
            "condition": {
                "text": "Sunny",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
            }
        },
        "astro": {
            "sunrise": "07:27 AM",
            "sunset": "07:32 PM"
        }
      }

      formatted_weather = forecast.format_daily_weather([daily])

      expect(formatted_weather[0][:date]).to eq('Sunday, September 24, 2023')
      expect(formatted_weather[0][:max_temp_f]).to eq(83.5)
      expect(formatted_weather[0][:min_temp_f]).to eq( 57.0)
      expect(formatted_weather[0][:condition]).to eq('Sunny')
      expect(formatted_weather[0][:icon]).to eq('//cdn.weatherapi.com/weather/64x64/day/113.png')

      hourly = [ 
        {
            "time": "2023-09-24 00:00",
            "temp_f": 63.7,
            "condition": {
                "text": "Clear",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
            }
        },
        {
            "time": "2023-09-24 01:00",
            "temp_f": 62.1,
            "condition": {
                "text": "Clear",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
            }
        }
      ]
      formatted_weather = forecast.format_hourly_weather(hourly)

      expect(formatted_weather[0][:time]).to eq('12:00 AM')
      expect(formatted_weather[0][:temperature]).to eq(63.7)
      expect(formatted_weather[0][:conditions]).to eq('Clear')
      expect(formatted_weather[0][:icon]).to eq('//cdn.weatherapi.com/weather/64x64/night/113.png')
    end
  end
end
