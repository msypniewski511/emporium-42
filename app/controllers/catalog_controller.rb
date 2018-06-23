class CatalogController < ApplicationController
  before_filter :initialize_cart

  def main
    @books = latest
  end

  def index
    @page_title = "Book List"
    #########Parent.includes(:children).paginate(:page => params[:page], :per_page => 30)
    @books = Book.includes(:authors, :publisher).paginate(page: params[:page], per_page: 10).order("books.id desc")
  end

  def show
    @book = Book.find(params[:id]) rescue nil
    #TODO implement get related books###########################################
    @related_books = Book.latest
    #############################################################################
    return render(text: "Not found", status: 404) unless @book
    @page_title = @book.title
    #TODO albo nowa albo nowy post dla knigu                                   #
    @subject = "Review for #{@book.title}"
    @rating = ForumPost.average_votes(@book.id)



    if ForumPost.where(book_id: @book.id).empty?
      @post = ForumPost.new(parent_id: 0, book_id: @book.id)
      @new_review = true
    else
      ##########################################################################
      #TODO pobranie elemtow rewiew dla publikacji##############################
      ##########################################################################
      @reviews = ForumPost.where(["book_id = ? and parent_id = ?", @book.id, 0])












      #@posts = ForumPost.where(["book_id = ? and parent_id = ?", @book.id, 0]).paginate(page: params[:page], per_page: 5)
      @posts = ForumPost.where(["book_id = ? and parent_id = ?", @book.id, 0]).page(params[:page] || 1).per_page(5)

      #Client.limit(5).offset(30)












      @post = ForumPost.new(parent_id: 0, book_id: @book.id)
      #@posts = ForumPost.where(book_id: @book.id)
      @new_review = false
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @ics }
      format.js
    end
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
