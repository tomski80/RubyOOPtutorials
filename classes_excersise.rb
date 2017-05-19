# simplest class ever
class BookInStock

  attr_accessor :price, :isbn

  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end
end

book1 = BookInStock.new('isbn1',3)
book2 = BookInStock.new('isbn2',3.14)
book3 = BookInStock.new('isbn3','5.67')

p book1.isbn
p book2.price
book2.price = 10
p book2.price
puts book3.isbn
