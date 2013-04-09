require "open-uri"

class BlogContentItem < ActiveRecord::Base
  include Expirable

  has_many :blog_content_matches, :dependent => :destroy
  has_many :tweets, :through => :blog_content_matches

  attr_accessible :blog_id,
                  :thumbnail_url,
                  :title

  validates :blog_id,
            :thumbnail_url,
            :title,
            :presence => true

  validates :thumbnail_url, :length => {:maximum => 1020}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Fetches additional metadata associated with the blog.
  def fetch_metadata
    self.title ||= blog.title
    self.thumbnail_url ||= blog.thumbnail_url
  rescue
    false
  end

  def blog
    @blog ||= Blog.new(blog_id)
  end

  def url
    blog.uri.to_s
  end
end
