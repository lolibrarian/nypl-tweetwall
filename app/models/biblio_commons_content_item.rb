class BiblioCommonsContentItem < ActiveRecord::Base
  extend Expirable

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

  before_validation :fetch_metadata

  expires_in 1.hour

  # Finds or creates a new BiblioCommonsContentItem record with the given title ID.
  def self.find_or_create(title_id, url)
    biblio_commons_content_item = find_by_title_id(title_id)
    return biblio_commons_content_item if biblio_commons_content_item

    create(:title_id => title_id, :url => url)
  end

  # Fetches additional metadata associated with the item.
  def fetch_metadata
    self.title ||= fetch_title
    self.thumbnail_url ||= fetch_thumbnail_url
  rescue
    false
  end

  # Fetches the item title from the BiblioCommons API.
  def fetch_title
    biblio_commons_api["title"]
  end

  # Fetches the thumbnail from Baker & Taylor.
  def fetch_thumbnail_url
    BakerTaylor.jacket_url(upc_or_isbn)
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
