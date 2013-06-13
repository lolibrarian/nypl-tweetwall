class DigitalCollectionsContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :digital_collections_content_item

  attr_accessible :tweet,
                  :digital_collections_content_item

  validates :tweet,
            :digital_collections_content_item,
            :presence => true

  content_match :content_id    => :mods_uuid,
                :content_class => :digital_collections_content_item

  def self.content_id_finder(url)
    DigitalCollections::MODS.mods_uuid_from_url(url)
  end
end
