class AddTextilizeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :converted_to_html, :text
  end
end
