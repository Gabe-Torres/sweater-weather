require 'rails_helper'

RSpec.describe 'Book Search Facade', :vcr do
  context 'instance methods' do
    scenario 'book_search' do
      books = BookSearchFacade.book_search('denver,co', 5)

      expect(books).to be_an(Array)
      expect(books.count).to eq(5)
      expect(books.first).to be_a(Book)
      expect(books.first.title).to be_a(String)
      expect(books.first.isbn).to be_an(Array)
      expect(books.first.isbn.first).to be_a(String)
      expect(books.first.title).to be_a(String)
    end
  end
end