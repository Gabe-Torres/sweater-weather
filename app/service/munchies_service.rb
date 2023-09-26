class MunchiesService 

  def self.conn
    require 'pry'; binding.pry
    conn = Faraday.new(url: "https://api.yelp.com") do |faraday|
      faraday.bearer_token = Rails.application.credentials.yelp[:key]
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_restaurants(location, quantity)
    get_url("/v3/businesses/search?location=#{location}&limit=#{quantity}")
  end

end