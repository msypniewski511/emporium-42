module Admin::AuthorHelper

  # TODO implement depracted method
  def error_messages_for(object)
    if !object.errors.empty?
      object.errors.messages.each do |key, val|
        "#{key} #{val}<br>"
      end
    end
  end
end
