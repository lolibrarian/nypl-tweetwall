class RemoteImage < ActiveRecord::Base
  MAX_TWEETWALL_WIDTH = 300

  attr_accessible :url

  validates :url,
            :width,
            :height,
            :presence => true
  validates :url, :length => {:maximum => 1020}

  before_validation :fetch_dimensions

  def fetch_dimensions
    return unless url

    # FastImage raises an exception if the URL is not URL-encoded. For
    # example, if a space is present.
    self.url = encoded_url

    self.width, self.height = FastImage.size(url)
  end

  # Returns a URL-encoded copy of the URL.
  def encoded_url
    URI::encode(url)
  end

  # Returns the preferred width of the remote image for the Tweetwall.
  def tweetwall_width
    (width > MAX_TWEETWALL_WIDTH) ? MAX_TWEETWALL_WIDTH : width
  end

  # Returns the preferred height of the remote image for the Tweetwall.
  def tweetwall_height
    (height * tweetwall_width) / width
  end
end
