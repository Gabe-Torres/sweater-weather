class BookSearchService 

  def self.conn 
    conn = Faraday.new(url: "https://openlibrary.org") 
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.book_search(query, quantity)
    require 'pry'; binding.pry
    get_url("/search.json?q=#{query}&limit=#{quantity}")
  end
end