class NastepnaZmiana < ActiveRecord::Migration
  def change
    add_foreign_key :authors_books, :authors
    add_foreign_key :authors_books, :books
  end
end
