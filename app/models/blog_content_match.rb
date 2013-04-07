class BlogContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :blog_content_item

  attr_accessible :tweet,
                  :blog_content_item

  validates :tweet,
            :blog_content_item,
            :presence => true

  content_match :content_id    => :blog_id,
                :content_class => :blog_content_item

  # Returns a blog ID (a unique portion of a NYPL Blogs URL), if found.
  def self.content_id_finder(url)
    uri = URI(url)
    return unless uri.host == Blog::HOST

    matches = uri.path.scan(/\A\/blog\/(.+)/).first
    return if matches.nil?

    matches.first
  end
end
