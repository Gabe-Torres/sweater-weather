class Book
  attr_reader :isbn, :title

  def initialize(book_data)
    # @id = nil
    # @type = 'books'
    
    @isbn = book_data[:isbn]
    @title = book_data[:title]
    # @books = format_books(book_data)
  end

  # def format_books(book_data)
  #   {
  #     isbn: book_data[:isbn],
  #     title: book_data[:title],
  #   }
  # end
end