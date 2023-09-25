class BookSearchFacade
  def self.book_search(query, quantity)
    response = BookSearchService.book_search(query, quantity)
    num_found = response[:numFound]
    book_data = response[:docs]
    books = book_data.map do |book_data|
      Book.new(book_data)
    end
    { num_found: num_found, books: books }
  end
end