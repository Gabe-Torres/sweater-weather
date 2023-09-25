require "rails_helper"

RSpec.describe Book do
  it 'has attributes' do
    book = Book.new({isbn: '1234', title: 'The Great Gatsby'})

    expect(book.books).to eq({isbn: '1234', title: 'The Great Gatsby'})
    expect(book).to be_a(Book)
  end
end