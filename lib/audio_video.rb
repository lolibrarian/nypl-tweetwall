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
  # Warning: this is *extremely* brittle (we're digging into the configuration
  # for the video embed code).
  def thumbnail_url
    flashvars = content.css('embed')[0]['flashvars'].split('&')
    image_flashvar = flashvars.find { |flashvar| flashvar.start_with?('image=') }
    url = image_flashvar.sub!('image=', '')
    CGI::unescape(url)
  end
end
