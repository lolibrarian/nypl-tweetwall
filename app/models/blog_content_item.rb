class BlogContentItem < ActiveRecord::Base
  include Expirable

  has_many :blog_content_matches, :dependent => :destroy
  has_many :tweets, :through => :blog_content_matches
  belongs_to :thumbnail, :class_name => RemoteImage, :dependent => :destroy

  attr_accessible :blog_id,
                  :title

  validates :blog_id,
            :title,
            :thumbnail_id,
            :presence => true
  validates :title, :length => {:maximum => 510}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the blog.
  def fetch_metadata
    self.title ||= blog.title
    self.thumbnail ||= RemoteImage.create(:url => blog.thumbnail_url)
  end

  def blog
    @blog ||= Blog.new(blog_id)
  end

  def url
    blog.uri.to_s
  end

  def glyphicon
    "comment"
  end
end
