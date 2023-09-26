require 'rails_helper'

RSpec.describe MunchiesSearch do
  it 'exists' do
    forecast = {:last_updated=>"Tuesday, September 26, 2023 10:45 AM",
      :temperature=>64.8,
      :feels_like=>64.8,
      :humidity=>26,
      :visibility=>9.0,
      :uvi=>6.0,
      :condition=>"Sunny",
      :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"}
      
    expected_forecast = {:summary=>"Sunny", :temperature=>64.8}
      search = MunchiesSearch.new('denver,co', forecast, 'restaurant')

    expect(search).to be_a(MunchiesSearch)
    expect(search.destination).to eq('denver,co')
    expect(search.forecast).to eq(expected_forecast)
    expect(search.restaurant).to eq('restaurant')
    expect(search.id).to eq(nil)
    expect(search).to have_attributes(destination: 'denver,co', forecast: expected_forecast, restaurant: 'restaurant', id: nil)
    expect(search.forecast).to be_a(Hash)
    expect(search.restaurant).to be_a(String)
    expect(search.restaurant).to eq('restaurant')
  end
end