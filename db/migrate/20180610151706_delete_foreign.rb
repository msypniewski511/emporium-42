class DeleteForeign < ActiveRecord::Migration
  def change
    say_with_time 'Adding foreign keys' do
      execute 'ALTER TABLE authors_books DROP CONSTRAINT fk_bk_authors'
      execute 'ALTER TABLE authors_books DROP CONSTRAINT fk_bk_books'
               #ALTER TABLE your_table DROP CONSTRAINT constraint_name;
    end
  end
end
