class URLRedirectFollower
  USER_AGENT = 'NYPL Tweetwall'

  def initialize(start_url)
    @start_url = start_url
  end

  def end_url
    curl = Curl::Easy.new(start_url) do |curl|
      curl.headers['User-Agent'] = USER_AGENT
      curl.follow_location = true
    end

    curl.perform
    curl.last_effective_url
  end

  private

  attr_reader :start_url
end
