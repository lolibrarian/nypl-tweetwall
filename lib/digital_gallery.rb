require "uri"
require "open-uri"

class DigitalGallery
  def initialize(image_id)
    @image_id = image_id
  end

  def document
    @document ||= Nokogiri::HTML(open uri)
  end

  def uri
    uri = URI.parse("http://digitalgallery.nypl.org/nypldigital/dgkeysearchdetail.cfm")
    params = {:imageID => @image_id}
    uri.query = URI.encode_www_form(params)

    uri
  end

  def title
    document.xpath("//meta[@name='dc.Title']/@content").to_s
  end

  def thumbnail_url
    uri = URI.parse("http://images.nypl.org/index.php")
    params = {
      :id => @image_id,
      :t => "w"
    }

    uri.query = URI.encode_www_form(params)

    uri.to_s
  end
end
