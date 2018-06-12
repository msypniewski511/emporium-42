class Author < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  # relations
  has_and_belongs_to_many :books
  before_destroy { books.clear }
  # Return full name from first_name and last_name
  def name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
