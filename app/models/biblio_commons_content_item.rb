class BiblioCommonsContentItem < ActiveRecord::Base
  include Expirable

  has_many :biblio_commons_content_matches, :dependent => :destroy
  has_many :tweets, :through => :biblio_commons_content_matches

  attr_accessible :title_id,
                  :thumbnail_url,
                  :title

  validates :title_id,
            :thumbnail_url,
            :title,
            :presence => true

  validates :thumbnail_url, :length => {:maximum => 1020}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the item.
  def fetch_metadata
    self.title ||= biblio_commons.title
    self.thumbnail_url ||= biblio_commons.thumbnail_url
  rescue
    false
  end

  def url
    biblio_commons.uri.to_s
  end

  def biblio_commons
    @response ||= BiblioCommons.new(title_id)
  end
end
