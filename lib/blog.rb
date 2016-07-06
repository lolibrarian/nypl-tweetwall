class Blog
  include NYPLContentType

  BASE_URI = URI.parse("https://www.nypl.org/blog/")
  CONTENT_SELECTOR = '.node-blog'

  # Extracts a NYPL Blogs ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless uri.host == BASE_URI.host

    matches = uri.path.scan(/\A\/blog\/(.+)/).first
    return if matches.nil?

    matches.first
  end
end
