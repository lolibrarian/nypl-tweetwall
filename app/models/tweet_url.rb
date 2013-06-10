require "open-uri"

class TweetUrl < ActiveRecord::Base
  belongs_to :tweet

  attr_accessible :original_url,
                  :expanded_url

  validates :original_url,
            :expanded_url,
            :presence => true
  validates :original_url,
            :expanded_url,
            :length => {:maximum => 1020}

  before_validation :expand_url

  # "Expands" the original URL by following all of the redirects.
  def expand_url
    self.expanded_url ||= open(original_url) { |file| file.base_uri.to_s }
  rescue
    false
  end
end
