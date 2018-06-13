class CatalogController < ApplicationController

  def index
    @page_title = "Book List"
    #########Parent.includes(:children).paginate(:page => params[:page], :per_page => 30)
    @books = Book.includes(:authors, :publisher).paginate(page: params[:page], per_page: 5).order("books.id desc")
  end

  def show
    @book = Book.find(params[:id]) rescue nil
    return render(text: "Not found", status: 404) unless @book
    @page_title = @book.title
  end

  def search
    @page_title = "Search for: #{params[:q]}" || "Search"
    @books_all = Book.includes(:authors, :publisher).where('lower(title) LIKE lower(?) OR lower(blurb) LIKE lower(?)', "%#{params[:q]}%", "%#{params[:q]}%")
    @books = @books_all.paginate(page: params[:page], per_page: 5).order("books.id desc")
    unless @books.size > 0
      flash.now[:notice] = "No books found matching your criteria"
    end
  end

  def latest
    @page_title = "Latest Books"
    @books = Book.latest
  end

  def rss
    @books = Book.latest
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
