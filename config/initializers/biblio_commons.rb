BiblioCommons.configure do |config|
  config.api_key = ENV["BIBLIOCOMMONS_API_KEY"]
  config.throttle_delay = 0.5
end
