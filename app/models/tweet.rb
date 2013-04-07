class Tweet < ActiveRecord::Base
  extend Expirable

  has_many :tweet_urls, :dependent => :destroy
  has_many :blog_content_matches, :dependent => :destroy
  has_many :blog_content_items, :through => :blog_content_matches

  attr_accessible :text,
                  :user_name,
                  :screen_name,
                  :profile_image_url,
                  :status_id,
                  :tweet_created_at

  validates :text,
            :user_name,
            :screen_name,
            :profile_image_url,
            :status_id,
            :tweet_created_at,
            :presence => true

  expires_in 1.day, :tweet_created_at

  # Finds or creates a new Tweet record (and associated TweetUrls) with the
  # given status object from the Twitter API (specifically, the Twitter gem).
  def self.find_or_create_from_api(status)
    tweet = find_by_status_id(status.id)
    return tweet if tweet

    tweet = create(
      :text              => status.text,
      :user_name         => status.user.name,
      :screen_name       => status.user.screen_name,
      :profile_image_url => status.user.profile_image_url,
      :status_id         => status.id,
      :tweet_created_at  => status.created_at
    )

    tweet.tweet_urls << status.urls.map { |url| TweetUrl.create_from_api(url) }
  end

  def url
    "https://twitter.com/#{screen_name}/status/#{status_id}"
  end
end
