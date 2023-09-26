class MunchiesFacade 
  def self.get_food(destination, food)
    response = MunchiesService.get_restaurants(destination, food)

    resturant_data = response[:businesses].take(1)

    restaurant = resturant_data.map do |restaurant|
      Restaurant.new(restaurant)
    end
    # food_data[:businesses].map do |restaurant|
    #   Restaurant.new(restaurant)
    # end
  end
end