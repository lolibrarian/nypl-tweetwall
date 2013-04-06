require "open-uri"

class TweetUrl < ActiveRecord::Base
  belongs_to :tweet

  before_save :expand_url

  attr_accessible :original_url,
                  :expanded_url

  def self.from_api(url)
    create(:original_url => url.expanded_url)
  end

  def expand_url
    return if original_url.nil?

    self.expanded_url ||= open(original_url) { |file| file.base_uri.to_s }
  end
end
