class MunchiesFacade 
  def self.get_food(destination, food)
    food_data = MunchiesService.get_restaurants(destination, food)
    food_data[:businesses].map do |restaurant|
      Restaurant.new(restaurant)
    end
  end
end