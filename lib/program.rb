class Program
  include NYPLContentType

  BASE_URI = URI.parse("https://www.nypl.org/events/programs/")
  CONTENT_SELECTOR = '.node-event_program'

  # Extracts a NYPL program ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless uri.host == BASE_URI.host

    matches = uri.path.scan(/\A\/events\/programs\/(.+)/).first
    return if matches.nil?

    matches.first
  end
end
