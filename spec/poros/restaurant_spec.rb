require 'rails_helper'

RSpec.describe Restaurant do
  it "has attributes" do
    restaurant = Restaurant.new({name: "Pasta Jay's", location: {display_address: ["123 Main St", "Denver, CO"]}, rating: 4.5, review_count: 100})

    expect(restaurant.name).to eq("Pasta Jay's")
    expect(restaurant.address).to eq("123 Main St, Denver, CO")
    expect(restaurant.rating).to eq(4.5)
    expect(restaurant.reviews).to eq(100)
    expect(restaurant).to be_a(Restaurant)
  end
end