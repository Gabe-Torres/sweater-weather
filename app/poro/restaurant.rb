class Restaurant
    attr_reader :name, :address, :rating, :reviews
  def initialize(data) 
    # binding.pry
    @name = data[:name]
    @address = data[:location][:display_address].join(", ")
    @rating = data[:rating]
    @reviews = data[:review_count]
  end
end