module Encore
  class Title
    BASE_ITEM_URI = URI('http://browse.nypl.org/iii/encore/record/C__R')

    def self.id_from_url(url)
      uri = URI(url)
      return unless uri.host == BASE_ITEM_URI.host

      matches = uri.path.scan(/\A\/iii\/encore\/record\/C__R(b\d+)/).first
      return if matches.nil?

      matches.first
    end

    def initialize(id)
      @id = id
    end

    def url
      "#{BASE_ITEM_URI}#{@id}"
    end

    def title
      element = document.css('#bibTitle').first
      return unless element.present?

      element.content.strip.lines.first.try(:chomp)
    end

    def thumbnail_url
      jacket_image_url || NYPLContentType::DEFAULT_THUMBNAIL_URL
    end

    def format
      element = document.css('#mediaTypeInsertComponent').first
      return unless element.present?

      element.content
    end

    private

    def document
      @document ||= Nokogiri::HTML(open url);
    end

    def jacket_image_url
      value = image_link_item_key
      return unless value.present?

      image = BakerTaylor::JacketImage.new(value)
      return unless image.available?

      image.url
    end

    # Extract the "ItemKey", a generic identifier for titles on Baker & Taylor
    # (as opposed to ISBN or UPC).
    def image_link_item_key
      element = document.css('#imageLinkComponent').first
      return unless element.present?

      url = element['href']
      return unless url.present?

      values = Addressable::URI.parse(url).query_values
      return unless values.present?

      values['ItemKey']
    end
  end
end
