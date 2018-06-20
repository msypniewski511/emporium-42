class CartController < ApplicationController
  before_filter :initialize_cart

  def view_cart
  end
  
  def add
    @book = Book.find(params[:id])
    if @item = @cart.add(params[:id])
      @current_item = @item
      flash.now[:cart_notice] = "Added #{@item.book.title}"
      respond_to do |format|
        format.html { redirect_to root_path, cart_notice: "Added #{@item.book.title}" }
        format.js { render action: "add_with_ajax", cart_notice: "Added #{@item.book.title}" }
      end
    end
  end

  def remove
    @book = Book.find(params[:id])

    if @item = @cart.remove(params[:id])
      @current_item = @item
      flash.now[:cart_notice] = "Removed 1 #{@item.book.title}"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: 'remove_with_ajax' }
      end
    end
  end

  def clear
    @cart.cart_items.destroy_all
    flash.now[:cart_notice] = "Cleard the cart"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render action: "clear_with_ajax" }
    end
  end
end
