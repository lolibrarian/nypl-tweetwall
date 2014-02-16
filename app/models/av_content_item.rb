class AvContentItem < ActiveRecord::Base
  include Expirable

  has_many :av_content_item_matches, :dependent => :destroy
  has_many :tweets, :through => :av_content_item_matches
  belongs_to :thumbnail, :class_name => RemoteImage, :dependent => :destroy, :autosave => true

  attr_accessible :av_id,
                  :title

  validates :av_id,
            :title,
            :thumbnail,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.day

  # Fetches additional metadata associated with the audio/video content item.
  def fetch_metadata
    self.title ||= audio_video.title
    self.thumbnail ||= RemoteImage.new(:url => audio_video.thumbnail_url)
  end

  def audio_video
    @audio_video ||= AudioVideo.new(av_id)
  end

  def url
    audio_video.uri.to_s
  end

  def glyphicon
    'play-button'
  end

  def category
    'audio_video'
  end
end
