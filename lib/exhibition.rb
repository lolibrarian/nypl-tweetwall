class Exhibition
  include NYPLContentType

  BASE_URI = URI.parse("http://www.nypl.org/events/exhibitions/")
  CONTENT_SELECTOR = '.node-event_exhibition'

  # Extracts a NYPL exhibition ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless uri.host == BASE_URI.host

    matches = uri.path.scan(/\A\/events\/exhibitions\/(.+)/).first
    return if matches.nil?

    matches.first
  end
end
