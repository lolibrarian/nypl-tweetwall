class DigitalGalleryContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :digital_gallery_content_item

  attr_accessible :tweet,
                  :digital_gallery_content_item

  validates :tweet,
            :digital_gallery_content_item,
            :presence => true

  content_match :content_id_finder => :image_id_from_url,
                :content_class     => :digital_gallery_content_item

  # Returns the image ID from the given URL, if found.
  def self.image_id_from_url(url)
    uri = URI(url)
    return unless (uri.host == gallery_uri.host) and (uri.path == gallery_uri.path)

    params_from_uri(uri)["imageID"]
  end

  def self.gallery_uri
    URI.parse(DigitalGallery::SEARCH_URL)
  end

  def self.params_from_uri(uri)
    Hash[*URI.decode_www_form(uri.query).flatten]
  end
end
