class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|

      t.column :name, :string, limit: 50, null: false
      t.column :subject, :string, limit: 255, null: false
      t.column :body, :text

      t.column :root_id, :integer, null: false, default: 0
      t.column :parent_id, :integer,  null: false, default: 0
      t.column :lft, :integer,  null: false, default: 0
      t.column :rgt, :integer,  null: false, default: 0
      t.column :depth, :integer,  null: false, default: 0

      ##########################################################################
      # relation to the book id                                                #
      # and vote                                                               #
      ##########################################################################
      t.column :book_id, :integer,  null: false, default: 0
      t.column :book_vote, :integer

      t.timestamps null: false
    end
  end
end
