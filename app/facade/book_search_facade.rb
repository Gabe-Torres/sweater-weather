class BookSearchFacade
  def self.book_search(query, quantity)
    BookSearchService.book_search(query, quantity).map do |book_data|
      Book.new(book_data)
    end
  end
end