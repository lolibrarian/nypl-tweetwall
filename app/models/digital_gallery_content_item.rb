class DigitalGalleryContentItem < ActiveRecord::Base
  include Expirable

  has_many :digital_gallery_content_matches, :dependent => :destroy
  has_many :tweets, :through => :digital_gallery_content_matches
  belongs_to :thumbnail, :class_name => RemoteImage, :dependent => :destroy, :autosave => true

  attr_accessible :image_id,
                  :title

  validates :image_id,
            :title,
            :thumbnail,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.day

  # Fetches additional metadata associated with the image.
  def fetch_metadata
    self.title ||= digital_gallery.title
    self.thumbnail ||= RemoteImage.new(:url => digital_gallery.thumbnail_uri.to_s)
  end

  def digital_gallery
    @digital_gallery ||= DigitalGallery.new(image_id)
  end

  def url
    digital_gallery.uri.to_s
  end

  def glyphicon
    "camera"
  end

  def category
    'images'
  end
end
