class ForumController < ApplicationController


  def index
    @page_title = "Forum"
    @posts = ForumPost.all.paginate(page: params[:page], per_page: 20).order("root_id desc, lft")
  end

  def reply
    reply_to = ForumPost.find(params[:id])
    @page_title = "Reply to '#{reply_to.subject}'"
    @post = ForumPost.new(parent_id: reply_to.id)
    render action: 'post'
  end

  def show
    @post = ForumPost.find(params[:id])
    @page_title = "#{@post.subject}"
  end

  def post
    @page_title = 'Post to forum'
    @post = ForumPost.new
  end

  def create
    @post = ForumPost.new(forum_post_params)

    respond_to do |format|
      if @post.save
        flash[:notice] = "Post was successfuly created."
        format.html { redirect_to action: 'index' }
        format.js { }
      else
        @page_title = 'Post to forum'
        format.html { render action: 'post' }
        format.js { }
      end
    end
  end

  def review_create
    @post = ForumPost.new(forum_post_params)
    @book = Book.find(params[:id]) rescue nil
    respond_to do |format|
      if @post.save
        @post_page = 0


        @book = Book.find(@post.book_id)
        @rating = ForumPost.average_votes(@book)
        @posts = ForumPost.where(["book_id = ? and parent_id = ?", @post.book_id, 0])
        @koniec = @posts.size/5

        # Search all posts for particular book and divide to pagination
        @posts = ForumPost.where(["book_id = ? and parent_id = ?", @book.id, 0]).
        offset(0).limit(5)


        flash[:notice] = "Post was successfuly created."
        format.html { redirect_to action: 'index' }
        format.js { render action: 'add_review_with_ajax'  }
      else
        @page_title = 'Post to forum'
        format.html { render action: 'post' }
        format.js { redirect_to catalog_item_path(id: @book.id) }
      end
    end
  end

  private

  def forum_post_params
    params.fetch(:forum_post, {}).permit(:parent_id, :name, :subject, :body, :book_id, :book_vote)
    #params.require(:forum_post).permit(:parent_id, :name, :subject, :body)
  end
end
