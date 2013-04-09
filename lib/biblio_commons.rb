require "uri"
require "open-uri"
require "json"

# BiblioCommons API documentation: http://developer.bibliocommons.com/docs
class BiblioCommons
  extend Throttleable

  BASE_API_URI = URI.parse("https://api.bibliocommons.com/v1/")
  BASE_ITEM_URI = URI.parse("http://nypl.bibliocommons.com/item/show/")

  class << self
    attr_accessor :api_key,
                  :throttle_delay
  end

  # Extracts a BiblioCommons title ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless uri.host == BASE_ITEM_URI.host

    matches = uri.path.scan(/\A\/item\/show\/(\d+)/).first
    return if matches.nil?

    matches.first
  end

  def self.configure(&block)
    yield(self)
  end

  def self.get(resource, params = {})
    throttle do
      uri = BASE_API_URI + resource
      uri.query = URI.encode_www_form(params.merge :api_key => api_key)

      body = open(uri).read
      JSON.parse(body)
    end
  end

  def initialize(id)
    @id = id
  end

  def uri
    BASE_ITEM_URI + @id.to_s
  end

  def titles
    @titles ||= self.class.get("titles/#{@id}")["title"]
  end

  def title
    titles["title"]
  end

  # Returns the first UPC (if present) or ISBN.
  def upc_or_isbn
    (upcs.present? ? upcs : isbns).first
  end

  def thumbnail_url
    BakerTaylor.jacket_url(upc_or_isbn)
  end

  def upcs
    titles["upcs"]
  end

  def isbns
    titles["isbns"]
  end
end
