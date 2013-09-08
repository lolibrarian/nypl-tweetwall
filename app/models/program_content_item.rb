class ProgramContentItem < ActiveRecord::Base
  include Expirable

  has_many :program_content_matches, :dependent => :destroy
  has_many :tweets, :through => :program_content_matches
  belongs_to :thumbnail, :class_name => RemoteImage, :dependent => :destroy

  attr_accessible :program_id,
                  :title

  validates :program_id,
            :title,
            :thumbnail_id,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the program.
  def fetch_metadata
    self.title ||= program.title
    self.thumbnail ||= RemoteImage.create(:url => program.thumbnail_url)
  end

  def program
    @program ||= Program.new(program_id)
  end

  def url
    program.uri.to_s
  end

  def glyphicon
    'calendar'
  end
end
