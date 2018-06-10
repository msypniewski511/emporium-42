class DeleteForig < ActiveRecord::Migration
  # Usunolem niepotrzebne klucze obce
  def change
    remove_foreign_key :authors_books, :authors
    remove_foreign_key :authors_books, :books
    #rename_column :books, :admin_publisher_id, :publisher_id
  end
end
