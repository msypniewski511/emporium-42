class ChangePublisher < ActiveRecord::Migration
  def change
    if  ActiveRecord::Base.connection.column_exists?(:books, :admin_publisher_id)
      rename_column :books, :admin_publisher_id, :publisher_id
    end
  end
end
