require 'rails_helper'

RSpec.describe 'Book Search Facade', :vcr do
  context 'instance methods' do
    scenario 'book_search' do
      books = BookSearchFacade.book_search('denver,co', 5)
      book = books[:books].first
      expect(book).to be_a(Book)
    
      # expect(books.count).to eq(5)
      expect(book).to be_an_instance_of(Book)
    end
  end
end