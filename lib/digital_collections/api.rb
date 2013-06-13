# NYPL Digital Collections API documentation:
#   http://api.repo.nypl.org/api_documentation
module DigitalCollections
  class API
    BASE_API_URI = URI("http://api.repo.nypl.org/api/v1/")

    class << self; attr_accessor :api_token; end

    def self.configure(&block)
      yield(self)
    end

    def self.get(resource, params = {})
      uri = BASE_API_URI + "#{resource}.json"
      uri.query = URI.encode_www_form(params)
      headers = {"Authorization" => "Token token=#{api_token}"}

      body = open(uri, headers).read
      JSON.parse(body)
    end
  end
end
