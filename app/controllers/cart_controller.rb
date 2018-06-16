class CartController < ApplicationController
  before_filter :initialize_cart


  def add
    @book = Book.find(params[:id])

    if request.post?
      @item = @cart.add(params[:id])
      flash[:notice] = "Added #{@item.book.title}"
    else
      render
    end
    redirect_to :root
  end
end
