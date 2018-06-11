class Admin::BooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_admin_book, only: [:show, :edit, :update, :destroy]
  before_action :load_date, only: [:new, :create, :edit, :update]

  # GET /admin/books
  # GET /admin/books.json
  def index
    @books = Book.all
  end

  # GET /admin/books/1
  # GET /admin/books/1.json
  def show
  end

  # GET /admin/books/new
  def new
    @book = Book.new
  end

  # GET /admin/books/1/edit
  def edit
  end

  # POST /admin/books
  # POST /admin/books.json
  def create
    @book = Book.new(admin_book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to admin_book_path(id: @book.id), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/books/1
  # PATCH/PUT /admin/books/1.json
  def update
    respond_to do |format|
      if @book.update(admin_book_params)
        format.html { redirect_to admin_book_path(id: @book.id), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/books/1
  # DELETE /admin/books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_book
      @book = Book.find(params[:id])
    end

    def load_date
      @authors = Author.all
      @publishers = Admin::Publisher.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_book_params
      params.require(:book).permit(:title, {:author_ids => []}, :publisher_id, :published_at, :isbn, :blurb, :page_count, :price)
    end
end
