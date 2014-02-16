class AudioVideo
  include NYPLContentType

  BASE_URI = URI.parse('http://www.nypl.org/audiovideo/')
  CONTENT_SELECTOR = '.node-av_content'

  # Extracts a NYPL audio/video ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless uri.host == BASE_URI.host

    matches = uri.path.scan(/\A\/audiovideo\/(.+)/).first
    return if matches.nil?

    matches.first
  end

  # Returns a thumbnail URL for the audio/video item.
  #
  # Warning: this is brittle (we're digging into the SWFObject configuration
  # stanza).
  def thumbnail_url
    content.to_s.match(/addVariable\('image','(.*)'/)[1]
  end
end
