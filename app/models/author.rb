class Author < ActiveRecord::Base

  # Return full name from first_name and last_name
  def name
    "#{first_name} #{last_name}"
  end
  
end
