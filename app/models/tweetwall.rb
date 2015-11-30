class Tweetwall
  # Expires the Tweetwall action cache.
  def self.expire
    # The entire Rails cache can be cleared since the Tweetwall actions are
    # the only thing cached.
    Rails.cache.clear
  end

  # Warms the Tweetwall action cache.
  def self.warm
    urls.each do |url|
      system "curl --silent --verbose #{url} --output /dev/null"
    end
  end

  # Returns all URLs for the application.
  def self.urls
    paths.map { |path| URI.join(www_url, path) }
  end

  # Returns the base WWW URL for the Tweetwall.
  def self.www_url
    ENV["WWW_URL"] || 'http://localhost:3000'
  end

  # Returns all unique paths for the application.
  def self.paths
    %w(
      /
      api/content_items/all
      api/content_items/blogs
      api/content_items/images
      api/content_items/books
      api/content_items/events
    )
  end
end
