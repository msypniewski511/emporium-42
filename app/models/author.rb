class Author < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  # Return full name from first_name and last_name
  def name
    "#{first_name} #{last_name}"
  end

end
