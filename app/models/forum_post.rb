class ForumPost < ActiveRecord::Base

  acts_as_nested_set :scope => :root

  def before_create
    # Update the child object with its parents attrs
    unless self[:parent_id].to_i.zero?
      self[:depth] = parent[:depth] + 1
      self[:root_id] = parent[:root_id]
    end
  end

  def after_create
    # Update the parent root_id with its id
    if self[:parent_id].to_i.zero?
      self[:root_id] = self[:id]
      self.save
    else
      parent.add_child self
    end
  end

  def parent
    @parent ||= self.class.find(self[:parent_id])
  end

  validates_length_of :name, within: 2..50
  validates_length_of :subject, within: 5..255
  validates_length_of :body, within: 5..5000


  ##############################################################################
  # moje methody
  def root?
    # Always if create new post withouth parent_id parent_id is default
    # thats mean post is first in thread
    parent_id == 0?true:false
  end

  def has_forum
    book_id!= 0
  end


  # return avarage of votes for particular book
  def self.average_votes(book_id)
    posts = ForumPost.where("book_id = ?", book_id)
    posts.size > 0 ? (posts.sum(:book_vote)/posts.size.to_f).round : 0
  end
end
