require "uri"
require "open-uri"
require "json"

# BiblioCommons API documentation: http://developer.bibliocommons.com/docs
class BiblioCommons
  VERSION = "v1"

  class << self; attr_accessor :api_key; end

  def self.configure(&block)
    yield(self)
  end

  def self.get(resource, params = {})
    uri = URI.parse("https://api.bibliocommons.com/#{VERSION}/#{resource}")
    uri.query = URI.encode_www_form(params.merge :api_key => api_key)

    body = open(uri).read
    JSON.parse(body)
  end

  def self.titles(id)
    get("titles/#{id}")["title"]
  end
end
