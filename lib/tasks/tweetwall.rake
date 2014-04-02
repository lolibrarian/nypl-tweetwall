namespace :tweetwall do
  desc "Updates the Tweetwall"
  task :update => [
    "content_items:delete_expired",
    'content_items:delete_overflow_tweets',
    "tweets:delete_expired",
    "tweets:delete_blocked",
    "tweets:update",
    "content_items:update",
    :expire,
    :warm
  ]

  desc "Expires the Tweetwall action cache"
  task :expire => :environment do
    Tweetwall.expire
  end

  desc "Warms the Tweetwall action cache"
  task :warm => :environment do
    Tweetwall.warm
  end
end
