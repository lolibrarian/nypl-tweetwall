class BiblioCommonsTitleContentItem < ActiveRecord::Base
  include Expirable
  extend Ribbonable

  has_many :biblio_commons_title_content_matches, :dependent => :destroy
  has_many :tweets, :through => :biblio_commons_title_content_matches

  attr_accessible :title_id,
                  :thumbnail_url,
                  :title

  validates :title_id,
            :thumbnail_url,
            :title,
            :presence => true

  validates :thumbnail_url, :length => {:maximum => 1020}

  validates :title, :length => {:maximum => 510}

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
    biblio_commons.url
  end

  def biblio_commons
    @response ||= BiblioCommons::Title.new(title_id)
  end
end
