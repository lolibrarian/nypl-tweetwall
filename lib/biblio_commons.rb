require "uri"
require "open-uri"
require "json"

# BiblioCommons API documentation: http://developer.bibliocommons.com/docs
class BiblioCommons
  extend Throttleable

  VERSION = "v1"
  NYPL_HOST = "nypl.bibliocommons.com"
  API_HOST = "api.bibliocommons.com"

  class << self
    attr_accessor :api_key,
                  :throttle_delay
  end

  def self.configure(&block)
    yield(self)
  end

  def self.get(resource, params = {})
    uri = URI.parse("https://#{API_HOST}/#{VERSION}/#{resource}")
    uri.query = URI.encode_www_form(params.merge :api_key => api_key)

    body = open(uri).read
    JSON.parse(body)
  end

  def self.titles(id)
    throttle { get("titles/#{id}")["title"] }
  end
end
