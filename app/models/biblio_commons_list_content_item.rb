class BiblioCommonsListContentItem < ActiveRecord::Base
  include Expirable

  has_many :biblio_commons_list_content_matches, :dependent => :destroy
  has_many :tweets, :through => :biblio_commons_list_content_matches
  belongs_to :thumbnail, :class_name => RemoteImage, :dependent => :destroy

  attr_accessible :list_id,
                  :title,
                  :user_id

  validates :list_id,
            :title,
            :user_id,
            :thumbnail_id,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the item.
  def fetch_metadata
    self.user_id ||= biblio_commons.user_id
    self.title ||= biblio_commons.name
    self.thumbnail ||= RemoteImage.create(:url => biblio_commons.thumbnail_url)
  end

  def url
    biblio_commons.url
  end

  def biblio_commons
    @biblio_commons ||= BiblioCommons::List.new(list_id, user_id)
  end

  def glyphicon
    "sort"
  end
end
