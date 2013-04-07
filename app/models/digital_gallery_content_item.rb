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

  # Finds or creates a new DigitalGalleryContentItem record with the given image ID.
  def self.find_or_create(image_id, url)
    digital_gallery_content_item = find_by_image_id(image_id)
    return digital_gallery_content_item if digital_gallery_content_item

    create(:image_id => image_id, :url => url)
  end

  # Fetches additional metadata associated with the image.
  def fetch_metadata
    self.title ||= fetch_title
    self.thumbnail_url ||= fetch_thumbnail_url
  rescue
    false
  end

  # Fetches the blog title from the digital gallery API.
  def fetch_title
    digital_gallery.title
  end

  # Fetches the blog thumbnail from the digital gallery API.
  def fetch_thumbnail_url
    digital_gallery.thumbnail_url
  end

  def digital_gallery
    @digital_gallery ||= DigitalGallery.new(image_id)
  end
end
