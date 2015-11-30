class EncoreTitleContentItem < ActiveRecord::Base
  include Expirable

  has_many :encore_title_content_matches, dependent: :destroy
  has_many :tweets, through: :encore_title_content_matches
  belongs_to :thumbnail, class_name: RemoteImage, dependent: :destroy, autosave: true

  attr_accessible :bib_id,
                  :title

  validates_presence_of :bib_id,
                        :title,
                        :thumbnail,
                        :format

  before_validation :fetch_metadata

  expires_in 1.week

  def fetch_metadata
    self.title ||= encore.title
    self.thumbnail ||= RemoteImage.new(:url => encore.thumbnail_url)
    self.format ||= encore.format
  end

  def url
    encore.url
  end

  def encore
    @encore ||= Encore::Title.new(bib_id)
  end

  def glyphicon
    case format
    when 'BLU-RAY', 'DVD', 'FILM,SLIDE,ETC', 'VHS' then 'film'
    when 'COMPUTER FILE', 'E-AUDIOBOOK', 'E-BOOK', 'E-VIDEO', 'GAME', 'WEB RESOURCE' then 'ipad'
    when 'MANUSCRIPT MUS', 'MUSIC CD', 'MUSIC NON-CD', 'SCORE', 'SPOKEN WORD', 'TEACHER AUDIO' then 'music'
    else 'book-open'
    end
  end

  def category
    'books'
  end
end
