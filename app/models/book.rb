class Book < ActiveRecord::Base
  before_validation :textilize_me
  require 'textilize'
  # relations
  belongs_to :publisher, class_name: 'Admin::Publisher'
  has_and_belongs_to_many :authors
  before_destroy { authors.clear }

  validates_length_of :title, in: 1..255
  validates_presence_of :publisher_id
  validates_presence_of :authors
  validates_presence_of :published_at
  validates_numericality_of :page_count, only_integer: true
  validates_numericality_of :price
  validates_format_of :isbn, with: /[0-9\-xX]{13}/
  validates_uniqueness_of :isbn

  ## Carrierwave
  mount_uploader :image, ImageUploader
  private

  # function make conversation to html just once before validation
  # instead using textilize each request it convert to html only before save
  # to database in column converted_to_html
  def textilize_me
    text = self.blurb || ''
    if text && text.respond_to?(:to_s)
      doc = RedCloth.new( text.to_s )
      doc.to_html
      self.converted_to_html = RedCloth.new(doc).to_html
    end
  end
end
