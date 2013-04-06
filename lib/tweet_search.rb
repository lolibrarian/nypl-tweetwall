class TweetSearch
  def query
    raise
  end

  def search_and_save_results
    search
    save_results
  end

  def search
    @results = Twitter.search(query)
  end

  def statuses
    @results.statuses
  end

  def logger
    @logger ||= Logger.new($stdout)
  end

  def save_results
    statuses.each_with_index do |status, index|
      logger.info "Status ID ##{status.id} (#{index + 1}/#{statuses.count})"
      Tweet.find_or_create_from_api(status)
    end
  end
end
