class BakerTaylor
  class << self
    attr_accessor :user_id,
                  :password
  end

  def self.configure(&block)
    yield(self)
  end

  class JacketImage
    BASE_URI = URI('http://contentcafe2.btol.com/ContentCafe/Jacket.aspx')

    OPTIONS = {
      # Request a pixel to be returned if no image is available (as opposed to a
      # placeholder image). Please see JacketImage#available?.
      :pixel_unless_available => {:Return => 1},
      # Request a medium-size image to be returned (the default is small).
      :medium_size_image => {:Type => 'M'}
    }

    PIXEL_DIMENSIONS = [1, 1]

    def initialize(value)
      @value = value
    end

    # Returns a jacket image URL for the assigned +value+.
    def url
      return @url if @url

      uri = BASE_URI.dup
      uri.query = URI.encode_www_form(params)

      @url = uri.to_s
    end

    # Returns +true+ if the jacket image URL is available.
    def available?
      dimensions = FastImage.size(url)
      return unless dimensions

      # Test to see that the image dimensions are those of a pixel, which is our
      # hint that the image isn't available.
      dimensions != PIXEL_DIMENSIONS
    end

  private

    # Returns a hash of parameters to request the jacket image URL for the
    # assigned +value+.
    def params
      params = {
        :userID   => BakerTaylor.user_id,
        :password => BakerTaylor.password,
        :Value    => @value
      }
      params.merge! OPTIONS[:medium_size_image]
      params.merge! OPTIONS[:pixel_unless_available]

      params
    end
  end
end
