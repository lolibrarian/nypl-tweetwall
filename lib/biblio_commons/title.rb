module BiblioCommons
  class Title
    BASE_ITEM_URI = URI('http://nypl.bibliocommons.com/item/show')

    # Extracts a BiblioCommons title ID from the given URL.
    def self.id_from_url(url)
      uri = URI(url)
      return unless uri.host == BASE_ITEM_URI.host

      matches = uri.path.scan(/\A\/item\/show\/(\d+)/).first
      return if matches.nil?

      matches.first
    end

    def initialize(id)
      @id = id
    end

    def url
      "#{BASE_ITEM_URI}/#{@id}"
    end

    def title
      titles['title']
    end

    # Returns a thumbnail URL for the title. If one can't be found, returns the
    # default NYPL thumbnail image URL instead.
    def thumbnail_url
      first_available_jacket_image_url || NYPLContentType::DEFAULT_THUMBNAIL_URL
    end

    # Returns a code for the format of the title.
    def format
      titles['format']['id']
    end

  private

    # Returns the first available jacket image URL. Returns +nil+ if none are
    # available.
    def first_available_jacket_image_url
      upcs_and_isbns.find do |value|
        jacket_image = BakerTaylor::JacketImage.new(value)
        break jacket_image.url if jacket_image.available?
      end
    end

    # Returns all of the title's UPCs and ISBNs in a single array (both are
    # useful in finding a thumbnail image).
    def upcs_and_isbns
      Array(titles['upcs']) + Array(titles['isbns'])
    end

    def titles
      @titles ||= API.get("titles/#{@id}")['title']
    end
  end
end
