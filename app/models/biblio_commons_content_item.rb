class BiblioCommonsContentItem < ActiveRecord::Base
  include Expirable

  has_many :biblio_commons_content_matches, :dependent => :destroy
  has_many :tweets, :through => :biblio_commons_content_matches

  attr_accessible :title_id,
                  :thumbnail_url,
                  :title,
                  :url

  validates :title_id,
            :thumbnail_url,
            :title,
            :url,
            :presence => true

  validates :url,
            :thumbnail_url,
            :length => {:maximum => 1020}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the item.
  def fetch_metadata
    self.title ||= biblio_commons_api["title"]
    self.thumbnail_url ||= BakerTaylor.jacket_url(upc_or_isbn)
  rescue
    false
  end

  # Returns the first UPC (if present) or ISBN.
  def upc_or_isbn
    (upcs.present? ? upcs : isbns).first
  end

  # Returns the UPCs from the BiblioCommons API.
  def upcs
    biblio_commons_api["upcs"]
  end

  # Returns the ISBNs from the BiblioCommons API.
  def isbns
    biblio_commons_api["isbns"]
  end

  # Fetches and caches the BiblioCommons API response.
  def biblio_commons_api
    @response ||= BiblioCommons.titles(title_id)
  end
end
