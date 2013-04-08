# A delegator (and base class) for all Tweet searching classes.
class TweetSearch
  # Returns all known Tweet searching classes.
  def self.classes
    [BlogTweetSearch, BiblioCommonsTweetSearch, DigitalGalleryTweetSearch]
  end

  # Updates all Twitter searches.
  def self.update
    classes.each do |klass|
      instance = klass.new
      instance.search_and_save_results
    end
  end

  # The text query to perform.
  def query
    raise
  end

  # The cap on the number of results.
  def limit
    Rails.env.production? ? 100 : 10
  end

  def search_and_save_results
    search
    save_results
  end

  def search
    @results = Twitter.search(query, :count => limit)
  end

  def statuses
    @results.statuses
  end

  def save_results
    statuses.each do |status|
      next if Tweet.find_by_status_id(status.id)

      tweet = Tweet.create(
        :status_id         => status.id,
        :text              => status.text,
        :user_name         => status.user.name,
        :screen_name       => status.user.screen_name,
        :profile_image_url => status.user.profile_image_url,
        :status_id         => status.id,
        :tweet_created_at  => status.created_at
      )

      next unless tweet

      tweet.tweet_urls << status.urls.map do |url|
        TweetUrl.create(:original_url => url.expanded_url)
      end
    end
  end
end
