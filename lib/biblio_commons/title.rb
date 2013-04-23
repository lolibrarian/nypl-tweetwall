module BiblioCommons
  class Title
    BASE_ITEM_URI = URI.parse("http://nypl.bibliocommons.com/item/show/")

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

    def uri
      BASE_ITEM_URI + @id.to_s
    end

    def titles
      @titles ||= API.get("titles/#{@id}")["title"]
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
end
