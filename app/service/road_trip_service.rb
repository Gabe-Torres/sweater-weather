class RoadTripService
  def self.conn
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params['key'] = Rails.application.credentials.mapquest[:key]
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_travel_time(origin, destination)
    # binding.pry
    data = get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
    data[:route][:formattedTime]
  end
end