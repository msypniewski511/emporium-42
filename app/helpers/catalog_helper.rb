module CatalogHelper

  def review_stars(var)
    title = case var
    when 0
      'No Votes'
    when 1
      'I hate it'
    when 2
      "I do not like it"
    when 3
      "It is okay"
    when 4
      'I like it'
    when 5
      'I love it'
    end
    output = "<span title='#{title}'>"
    (0...5).each do |i|
      if var <= i
        output = output + "<i class='far fa-star'></i>"
      else
        output += "<i class='fas fa-star'></i>"
      end
    end
    output += "</span>"
  end


end
