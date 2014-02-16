module DigitalCollections
  class MODS
    BASE_MODS_URI = URI("http://digitalcollections.nypl.org/items/")

    # Extracts a MODS UUID from the given URL.
    def self.mods_uuid_from_url(url)
      uri = URI(url)
      return unless uri.host == BASE_MODS_URI.host

      matches = uri.path.scan(/\A\/items\/(\w+-\w+-\w+-\w+-\w+)/).first
      return if matches.nil?

      matches.first
    end

    def initialize(mods_uuid)
      @mods_uuid = mods_uuid
    end

    def title
      titles = [mods['titleInfo']].flatten
      titles.last['title']['$']
    end

    def thumbnail_uri
      captures.thumbnail_uri
    end

    def url
      (BASE_MODS_URI + @mods_uuid).to_s
    end

  private

    def mods
      @mods ||= API.get("items/mods/#{@mods_uuid}")["nyplAPI"]["response"]["mods"]
    end

    def capture_uuid
      mods["identifier"].find { |identifier| identifier["type"] == "uuid" }["$"]
    end

    def captures
      @captures ||= DigitalCollections::Captures.new(capture_uuid)
    end
  end
end
