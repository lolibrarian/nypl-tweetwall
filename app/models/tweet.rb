class Tweet < ActiveRecord::Base
  include Expirable

  # Returns an array of blacklisted Twitter screen names.
  SCREEN_NAME_BLACKLIST = ENV["TWITTER_SCREEN_NAME_BLACKLIST"].to_s.split(",")

  has_many :tweet_urls, :dependent => :destroy
  has_many :blog_content_matches, :dependent => :destroy
  has_many :blog_content_items, :through => :blog_content_matches
  has_many :biblio_commons_title_content_matches, :dependent => :destroy
  has_many :biblio_commons_title_content_items, :through => :biblio_commons_title_content_matches
  has_many :digital_gallery_content_matches, :dependent => :destroy
  has_many :digital_gallery_content_items, :through => :digital_gallery_content_matches
  has_one :retweeted_tweet, :class_name => Tweet, :primary_key => :retweeted_status_id, :foreign_key => :status_id

  attr_accessible :text,
                  :user_name,
                  :screen_name,
                  :profile_image_url,
                  :status_id,
                  :tweet_created_at,
                  :retweeted_status_id

  validates :text,
            :user_name,
            :screen_name,
            :profile_image_url,
            :status_id,
            :tweet_created_at,
            :presence => true
  validate :unexpired?,
           :permitted?,
           :on => :create

  expires_in 3.days, :tweet_created_at

  scope :blocked, where("screen_name IN (?)", SCREEN_NAME_BLACKLIST)

  # Adds a validation error if blocked.
  def permitted?
    errors.add(screen_name, "is blocked") if blocked?
  end

  # Returns +true+ if this Tweet is blocked from being created.
  def blocked?
    SCREEN_NAME_BLACKLIST.include?(screen_name)
  end

  def profile_url
    "https://twitter.com/#{screen_name}"
  end

  def url
    "#{profile_url}/status/#{status_id}"
  end

  def retweet?
    retweeted_status_id?
  end

  # Returns +true+ if the tweet ought to be truncated within the given set of
  # tweets. The rules are:
  #
  #   1. If it's not a retweet, do not truncate.
  #
  #   2. If it is a retweet, and the retweeted tweet is *not* the given set,
  #      do not truncate.
  #
  #   3. Otherwise, truncate.
  #
  def truncate?(tweets)
    return false unless retweet?

    tweets.find { |tweet| tweet.status_id == self.retweeted_status_id }
  end
end
