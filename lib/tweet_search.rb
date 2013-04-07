class TweetSearch
  def query
    raise
  end

  def search_and_save_results
    search
    save_results
  end

  def search
    @results = Twitter.search(query, :count => 100)
  end

  def statuses
    @results.statuses
  end

  def save_results
    statuses.each { |status| Tweet.find_or_create_from_api(status) }
  end
end
