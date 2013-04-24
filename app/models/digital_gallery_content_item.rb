require "open-uri"

class DigitalGalleryContentItem < ActiveRecord::Base
  include Expirable
  extend Ribbonable

  has_many :digital_gallery_content_matches, :dependent => :destroy
  has_many :tweets, :through => :digital_gallery_content_matches

  attr_accessible :image_id,
                  :title

  validates :image_id,
            :title,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the image.
  def fetch_metadata
    self.title ||= digital_gallery.title
  rescue
    false
  end

  def digital_gallery
    @digital_gallery ||= DigitalGallery.new(image_id)
  end

  def url
    digital_gallery.uri.to_s
  end

  def thumbnail_url
    digital_gallery.thumbnail_uri.to_s
  end
end
