class MunchiesService 

  def self.conn
    conn = Faraday.new(url: "https://api.yelp.com/v3") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

  def self.get_url(url)
    # binding.pry
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_restaurants(location, food)
    # require 'pry'; binding.pry
    get_url("businesses/search?location=#{location}&term=#{food}")
  end
end