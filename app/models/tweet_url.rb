require "open-uri"

class TweetUrl < ActiveRecord::Base
  belongs_to :tweet

  attr_accessible :original_url,
                  :expanded_url

  validates :original_url,
            :expanded_url,
            :presence => true

  before_validation :expand_url

  # Creates a new TweetUrl record with the given url object from the Twitter
  # API (specifically, the Twitter gem).
  def self.create_from_api(url)
    create(:original_url => url.expanded_url)
  end

  # "Expands" the original URL by following all of the redirects.
  def expand_url
    self.expanded_url ||= open(original_url) { |file| file.base_uri.to_s }
  rescue
    false
  end
end
