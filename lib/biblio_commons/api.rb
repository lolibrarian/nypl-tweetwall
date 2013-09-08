# BiblioCommons API documentation: http://developer.bibliocommons.com/docs
module BiblioCommons
  module API
    extend Throttleable

    BASE_API_URI = URI.parse("https://api.bibliocommons.com/v1/")

    class << self
      attr_accessor :api_key,
                    :throttle_delay
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
  end
end
