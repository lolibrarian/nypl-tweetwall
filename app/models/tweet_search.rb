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
    statuses.each { |status| Tweet.find_or_create_from_api(status) }
  end
end
