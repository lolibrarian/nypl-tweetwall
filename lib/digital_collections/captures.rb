module DigitalCollections
  class Captures
    def initialize(capture_uuid)
      @capture_uuid = capture_uuid
    end

    def thumbnail_uri
      DigitalGallery.new(image_id).thumbnail_uri
    end

  private

    def captures
      @captures ||= API.get("items/#{@capture_uuid}")["nyplAPI"]["response"]["capture"]
    end

    def capture
      captures.first
    end

    def image_id
      capture["imageID"]
    end
  end
end
