require "open-uri"

class BlogContentItem < ActiveRecord::Base
  extend Expirable

  has_many :blog_content_matches, :dependent => :destroy
  has_many :tweets, :through => :blog_content_matches

  attr_accessible :blog_id,
                  :thumbnail_url,
                  :title,
                  :url

  validates :blog_id,
            :thumbnail_url,
            :title,
            :url,
            :presence => true

  validates :url,
            :thumbnail_url,
            :length => {:maximum => 1020}

  before_validation :fetch_metadata

  expires_in 1.hour

  # Finds or creates a new BlogContentItem record with the given blog ID.
  def self.find_or_create(blog_id, url)
    blog_content_item = find_by_blog_id(blog_id)
    return blog_content_item if blog_content_item

    create(:blog_id => blog_id, :url => url)
  end

  # Fetches additional metadata associated with the blog.
  def fetch_metadata
    self.title ||= blog.title
    self.thumbnail_url ||= blog.thumbnail_url
  rescue
    false
  end

  def blog
    @blog ||= Blog.new(url)
  end
end
