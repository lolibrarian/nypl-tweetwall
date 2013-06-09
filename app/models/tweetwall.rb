class Tweetwall
  # Expires the Tweetwall action cache.
  def self.expire
    # The entire Rails cache can be cleared since the Tweetwall actions are
    # the only thing cached.
    Rails.cache.clear
  end

  # Warms the Tweetwall action cache.
  def self.warm
    urls.each { |url| `curl --silent --get --head #{url}` }
  end

  # Returns all URLs for the application.
  def self.urls
    paths.map { |path| URI.join(www_url, path) }
  end

  # Returns the base WWW URL for the Tweetwall.
  def self.www_url
    ENV["WWW_URL"] || "http://localhost"
  end

  # Returns all unique paths for the application.
  def self.paths
    Rails.application.routes.routes.map { |route| route.path.spec.left.to_s }.uniq
  end
end
