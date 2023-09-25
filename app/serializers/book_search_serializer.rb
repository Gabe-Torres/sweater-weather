class BookSearchSerializer
  include JSONAPI::Serializer
  attributes :id, :total_books_found, :books
end