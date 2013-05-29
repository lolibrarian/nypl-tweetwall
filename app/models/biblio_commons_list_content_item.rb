class BiblioCommonsListContentItem < ActiveRecord::Base
  include Expirable

  has_many :biblio_commons_list_content_matches, :dependent => :destroy
  has_many :tweets, :through => :biblio_commons_list_content_matches

  attr_accessible :list_id,
                  :thumbnail_url,
                  :title,
                  :user_id

  validates :list_id,
            :thumbnail_url,
            :title,
            :user_id,
            :presence => true

  validates :thumbnail_url, :length => {:maximum => 1020}

  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the item.
  def fetch_metadata
    self.user_id ||= biblio_commons.user_id
    self.title ||= biblio_commons.name
    self.thumbnail_url ||= biblio_commons.thumbnail_url
  rescue
    false
  end

  def url
    biblio_commons.url
  end

  def biblio_commons
    @response ||= BiblioCommons::List.new(list_id, user_id)
  end
end
