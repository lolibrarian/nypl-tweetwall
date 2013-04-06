class Tweet < ActiveRecord::Base
  has_many :tweet_urls

  attr_accessible :text,
                  :user_name,
                  :screen_name,
                  :profile_image_url,
                  :status_id,
                  :tweet_created_at

  def self.find_or_create_from_api(status)
    tweet = find_by_status_id(status.id)
    return tweet if tweet

    tweet = create(
      :text => status.text,
      :user_name => status.user.name,
      :screen_name => status.user.screen_name,
      :profile_image_url => status.user.profile_image_url,
      :status_id => status.id,
      :tweet_created_at => status.created_at
    )
    tweet.tweet_urls << status.urls.map { |url| TweetUrl.from_api(url) }

    tweet
  end
end
