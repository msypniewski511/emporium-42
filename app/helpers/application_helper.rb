module ApplicationHelper

  def add_book_link(text, book)
    link_to text,
    {
      controller: 'cart',
      action: "add",
      id: book
    }, method: "POST", remote: true, title: "Add to Cart"
  end

  def remove_book_link(text, book)
    link_to text, {
      controller: 'cart',
      action: "remove",
      id: book
    }, method: "POST", remote: true, title: "Remove book"
  end

  def clear_cart_link(text="Clear Cart")
    link_to text, {
      controller: 'cart',
      action: 'clear'
    }, method: "POST", remote: true, title: "Clear Cart!"
  end


end
