module Admin::BooksHelper

  def display_tags_for_book(book)
    book.tags.collect{|tag| tag.name}.join(', ') if book.tags
  end

  def display_tags_and_tagging_acount(book)
    output = ""
    book.tags.each do |tag|
      #link_to tag.name, tag_path(tag)
      output  += "<a href=\"/tags/#{tag}\" class=\"tag_item\" title=\"Show #{tag.taggings_count} more books tagged: ''#{tag}''\">#{tag} <span class=\"tag_item_count\"> #{tag.taggings_count}</span></a>"
      #outpu += '<a href="#" class="tag_item">"#{tag.name}"</a>'
    end
    output
    #raw(book.tags.map { |t| link_to t, tag_path(t.name), title: "#{t.taggings_count} match(es)" })
  end

  def display_tags_as_link(book)
    raw(book.tags.map { |t| link_to t, tag_path(t.name), title: "#{t.taggings_count} match(es)" }.join(', '))
  end
end
