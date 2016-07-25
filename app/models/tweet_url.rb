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
    self.expanded_url ||= URLRedirectFollower.new(original_url).end_url
  rescue
    false
  end
end
