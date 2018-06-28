# app/controllers/tags_controller.rb

class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @page_title = "Books tagged with #{params[:id]}"
    #@tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @books = Book.tagged_with(params[:id])
  end
end
