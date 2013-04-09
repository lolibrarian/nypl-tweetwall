class DigitalGalleryContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :digital_gallery_content_item

  attr_accessible :tweet,
                  :digital_gallery_content_item

  validates :tweet,
            :digital_gallery_content_item,
            :presence => true

  content_match :content_id    => :image_id,
                :content_class => :digital_gallery_content_item

  def self.content_id_finder(url)
    DigitalGallery.id_from_url(url)
  end
end
