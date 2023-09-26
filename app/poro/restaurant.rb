class Restaurant
    attr_reader :id, :name, :address, :rating, :reviews
  def initialize(data)
    @id = nil 
    @name = data[:name]
    @address = data[:location][:display_address].join(", ")
    @rating = data[:rating]
    @reviews = data[:review_count]
  end
end