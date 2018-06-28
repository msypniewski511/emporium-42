class CatalogController < ApplicationController
  PAGE_SIZE = 5
  before_filter :initialize_cart

  def main
    @books = latest
  end

  def index
    @page_title = "Book List"
    #########Parent.includes(:children).paginate(:page => params[:page], :per_page => 30)
    @books = Book.includes(:authors, :publisher).paginate(page: params[:page], per_page: 10).order("books.id desc")
  end



  ##############################################################################################
  def show

    # Variables require to related books
    @related_page = (params[:related_page] || 0).to_i


    #@page = (params[:post_page]||0).to_i
    @book = Book.find(params[:id]) rescue nil

    if session[:book_id] == params[:id]
      if params[:post_page].to_i == 1
        session[:page_session] += 1
      else
        session[:page_session] -= 1
      end
    else
      session[:book_id] = params[:id]
      session[:page_session] = 0
    end

    @page = (session[:page_session]>=0 ? session[:page_session] : 0)
    session[:page_session] = @page


    #TODO implement get related books###########################################
    #@related_books = @book.find_related_tags.paginate(page: params[:page], per_page: 5).order("books.id desc")
    @related_pages_amount = (@book.find_related_tags.all.length/5.0).ceil
    @related_books = @book.find_related_tags.
    offset(5*@related_page).limit(5)
    ############################################################################


    return render(text: "Not found", status: 404) unless @book
    @page_title = @book.title
    #TODO albo nowa albo nowy post dla knigu                                   #
    @subject = "Review for #{@book.title}"
    @rating = ForumPost.average_votes(@book.id)


    ############################################################################
    # Check amount of posts for particular book and if is empty create new one #
    # for form                                                                 #
    ############################################################################
    if ForumPost.where(book_id: @book.id).empty?
      @post = ForumPost.new(parent_id: 0, book_id: @book.id)
      @new_review = true
    else


      ##########################################################################
      #TODO pobranie elemtow rewiew dla publikacji##############################
      ##########################################################################
      @reviews = ForumPost.where(["book_id = ? and parent_id = ?", @book.id, 0])
      @koniec = @reviews.size/PAGE_SIZE

      # Search all posts for particular book and divide to pagination
      @posts = ForumPost.where(["book_id = ? and parent_id = ?", @book.id, 0]).
      offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
      #########################################################################

      @post = ForumPost.new(parent_id: 0, book_id: @book.id)
      @new_review = false
    end





    respond_to do |format|
      format.html
      format.xml  { render :xml => @ics }
      format.js { render 'show', :locals => {:page_id => session[:page_session]}}
    end
  end


  ###########################################################################################
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
