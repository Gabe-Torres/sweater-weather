class ForecastService 
  
  def self.conn
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
    faraday.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def self.conn2
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_url2(url)
    response = conn2.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_location(location)
    data = get_url("/geocoding/v1/address?location=#{location}")
    data[:results][0][:locations][0][:latLng]
  end

  def self.get_forecast(location)
    latlng = get_location(location)
    get_url2("/v1/forecast.json?q=#{latlng[:lat]},#{latlng[:lng]}")
  end
end