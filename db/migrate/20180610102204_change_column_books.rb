class ChangeColumnBooks < ActiveRecord::Migration
  def change
    add_foreign_key :authors_books, :authors
    add_foreign_key :authors_books, :books
    #rename_column :books, :admin_publisher_id, :publisher_id
  end
end
