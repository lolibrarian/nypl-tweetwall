namespace :tweetwall do
  desc "Updates the Tweetwall"
  task :update => [
    "content_items:delete_expired",
    "tweets:delete_expired",
    "tweets:update",
    "content_items:update",
    :expire
  ]

  desc "Expires the Tweetwall action cache"
  task :expire => :environment do
    Rails.cache.clear
  end
end
