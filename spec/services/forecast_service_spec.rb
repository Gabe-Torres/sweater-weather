require 'rails_helper'

RSpec.describe 'Forecast Service' do
  context 'instance methods' do
    context '#get_forecast' do
      scenario 'returns a forecast object', :vcr do
        forecast_service = ForecastService.get_forecast('denver,co')
        conn = ForecastService.conn
        location = 'denver,co'

        expect(forecast_service).to be_a(Hash)
        expect(conn.url_prefix.to_s).to eq('https://www.mapquestapi.com/')
      end
    end
  end
end