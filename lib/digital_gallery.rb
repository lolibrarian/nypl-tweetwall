require "uri"
require "open-uri"

class DigitalGallery
  SEARCH_URL = "http://digitalgallery.nypl.org/nypldigital/dgkeysearchdetail.cfm"
  IMAGE_URL = "http://images.nypl.org/index.php"

  def initialize(image_id)
    @image_id = image_id
  end

  def document
    @document ||= Nokogiri::HTML(open(uri), nil, "UTF-8")
  end

  def uri
    uri = URI.parse(SEARCH_URL)
    params = {:imageID => @image_id}
    uri.query = URI.encode_www_form(params)

    uri
  end

  def title
    document.xpath("//meta[@name='dc.Title']/@content").to_s
  end

  def thumbnail_url
    uri = URI.parse(IMAGE_URL)
    params = {
      :id => @image_id,
      :t => "w"
    }

    uri.query = URI.encode_www_form(params)

    uri.to_s
  end
end
