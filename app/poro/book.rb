class Book
  attr_reader :type, :books, :id

  def initialize(book_data)
    @id = nil
    @type = 'books'
    @books = format_books(book_data)
  end

  def format_books(book_data)
      {
        isbn: book_data[:isbn],
        title: book_data[:title],
      }
  end
end