require "open-uri"

class DigitalGalleryContentItem < ActiveRecord::Base
  extend Expirable

  has_many :digital_gallery_content_matches, :dependent => :destroy
  has_many :tweets, :through => :digital_gallery_content_matches

  attr_accessible :image_id,
                  :thumbnail_url,
                  :title,
                  :url

  validates :image_id,
            :thumbnail_url,
            :title,
            :url,
            :presence => true

  validates :url,
            :thumbnail_url,
            :length => {:maximum => 1020}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the image.
  def fetch_metadata
    self.title ||= digital_gallery.title
    self.thumbnail_url ||=  digital_gallery.thumbnail_url
  rescue
    false
  end

  def digital_gallery
    @digital_gallery ||= DigitalGallery.new(image_id)
  end
end
