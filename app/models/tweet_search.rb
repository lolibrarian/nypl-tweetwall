# A delegator (and base class) for all Tweet searching classes.
class TweetSearch
  # Returns all known Tweet searching classes.
  def self.classes
    [
      BlogTweetSearch,
      DigitalGalleryTweetSearch,
      DigitalCollectionsTweetSearch,
      ProgramTweetSearch,
      ExhibitionTweetSearch,
      AvTweetSearch,
      EncoreTitleTweetSearch
    ]
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
    @results = Twitter.search(query, :count => limit) rescue nil
  end

  def statuses
    return unless @results

    @results.statuses
  end

  def save_results
    return unless statuses

    statuses.each do |status|
      next if Tweet.find_by_status_id(status.id)

      tweet = Tweet.new(
        # The Tweet text needs to be HTML unescaped. Please see:
        #   https://github.com/sferik/twitter/issues/348
        :text                => CGI.unescapeHTML(status.text),
        :user_name           => status.user.name,
        :screen_name         => status.user.screen_name,
        :profile_image_url   => status.user.profile_image_url,
        :status_id           => status.id,
        :tweet_created_at    => status.created_at
      )

      tweet.retweeted_status_id = status.retweeted_tweet.id if status.retweet?

      next unless tweet.save

      status.urls.map do |url|
        tweet.tweet_urls << TweetUrl.new(:original_url => url.expanded_url)
      end
    end
  end
end
