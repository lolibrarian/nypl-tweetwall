class ExhibitionContentItem < ActiveRecord::Base
  include Expirable

  has_many :exhibition_content_matches, :dependent => :destroy
  has_many :tweets, :through => :exhibition_content_matches
  belongs_to :thumbnail, :class_name => RemoteImage, :dependent => :destroy, :autosave => true

  attr_accessible :exhibition_id,
                  :title

  validates :exhibition_id,
            :title,
            :thumbnail,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the exhibition.
  def fetch_metadata
    self.title ||= exhibition.title
    self.thumbnail ||= RemoteImage.new(:url => exhibition.thumbnail_url)
  end

  def exhibition
    @exhibition ||= Exhibition.new(exhibition_id)
  end

  def url
    exhibition.uri.to_s
  end

  def glyphicon
    'calendar'
  end

  def category
    'events'
  end
end
