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

  def self.content_id_finder(url)
    Blog.id_from_url(url)
  end
end
