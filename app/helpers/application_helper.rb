module ApplicationHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(email, size=40)
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: email, class: "gravatar")
  end

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
    }, method: "POST", remote: true, title: "Remove book", class: 'btn-small'
  end

  def clear_cart_link(text="CLEAR CART")
    link_to text, {
      controller: 'cart',
      action: 'clear'
    }, method: "POST", remote: true, title: "Clear Cart!", class: 'btn-small hover-red'
  end


end
