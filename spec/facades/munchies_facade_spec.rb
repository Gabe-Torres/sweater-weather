require 'rails_helper'

RSpec.describe 'Munchies facade', :vcr do
  context 'instance methods' do
    scenario 'get_restaurants' do
      resturant = MunchiesFacade.get_food('denver,co', 'italian')

      expect(resturant).to be_a(Array)
      expect(resturant.first).to be_a(Restaurant)
      expect(resturant.first.name).to be_a(String)
      expect(resturant.first.address).to be_a(String)
      expect(resturant.first.rating).to be_a(Float)
      expect(resturant.first.reviews).to be_a(Integer)
      expect(resturant.first).to have_attributes(name: resturant.first.name, address: resturant.first.address, rating: resturant.first.rating, reviews: resturant.first.reviews)
    end
  end
end