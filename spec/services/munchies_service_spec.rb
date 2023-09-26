require 'rails_helper'

RSpec.describe "MunchiesService" do
  describe "class methods" do
    describe "get_restaurants" do
      it "returns a hash of restaurant data", :vcr do
        munchie_return = MunchiesService.get_restaurants("denver,co", "chinese")
        conn = MunchiesService.conn

        location = "denver,co"
        food = "chinese"

        expect(munchie_return).to be_a(Hash)
        expect(conn.headers["Authorization"]).to eq("Bearer #{Rails.application.credentials.yelp[:key]}")
        expect(conn.url_prefix.to_s).to eq("https://api.yelp.com/v3")
        expect(conn.params).to eq({})

      expect(MunchiesService).to receive(:get_url).with('businesses/search?location=denver,co&term=chinese')
      MunchiesService.get_restaurants(location, food)

      end
    end
  end
end