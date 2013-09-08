class DigitalGallery
  BASE_SEARCH_URI = URI.parse("http://digitalgallery.nypl.org/nypldigital/dgkeysearchdetail.cfm")
  BASE_IMAGE_URI = URI.parse("http://images.nypl.org/index.php")

  # Extracts a digital gallery image ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless (uri.host == BASE_SEARCH_URI.host) and (uri.path == BASE_SEARCH_URI.path)

    params = params_from_uri(uri)
    return unless params

    # The image ID parameter is not consistently capitalized between different
    # versions of the "Image Details" page, so perform a case-insensitive
    # search.
    params.find { |key, value| key.downcase == "imageid" }.try(:last)
  end

  # Returns a params hash from the given URI.
  def self.params_from_uri(uri)
    Hash[*URI.decode_www_form(uri.query).flatten] rescue nil
  end

  def initialize(id)
    @id = id
  end

  def document
    @document ||= Nokogiri::HTML(open(uri), nil, "UTF-8")
  end

  # Returns a query string from the given params hash.
  def params_to_query(params)
    URI.encode_www_form(params)
  end

  def uri
    uri = BASE_SEARCH_URI.dup
    params = {:imageID => @id}
    uri.query = params_to_query(params)

    uri
  end

  def title
    document.xpath("//meta[@name='dc.Title']/@content").to_s
  end

  def thumbnail_uri
    uri = BASE_IMAGE_URI.dup
    params = {
      :id => @id,
      :t => "w"
    }

    uri.query = params_to_query(params)

    uri
  end
end
