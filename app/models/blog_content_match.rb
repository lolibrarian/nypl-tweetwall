class BlogContentMatch < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :blog_content_item

  attr_accessible :tweet,
                  :blog_content_item

  validates :tweet,
            :blog_content_item,
            :presence => true

  # Iterates through the TweetUrls associated with the given Tweet instance,
  # looking for blog IDs. If a blog ID is found, it is then found or created.
  # Finally, the match is made.
  def self.find_or_create_content_items(tweet)
    tweet.tweet_urls.each do |tweet_url|
      url = tweet_url.expanded_url
      blog_id = self.blog_id_from_url(url)
      next unless blog_id

      blog_content_item = BlogContentItem.find_or_create(blog_id, url)
      next unless blog_content_item

      find_or_create_by_tweet_id_and_blog_content_item_id(tweet.id, blog_content_item.id)
    end
  end

  # Returns a "blog ID" (a unique portion of a NYPL Blogs URL), if found.
  def self.blog_id_from_url(url)
    uri = URI(url)
    return unless uri.host == "www.nypl.org"

    match = uri.path.scan(/\A\/blog\/(.*)/).first
    return if match.nil?

    match.first
  end
end
