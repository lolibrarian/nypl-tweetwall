namespace :content_items do
  desc "Updates content items (associated with Tweets)"
  task :update => :environment do
    ContentMatch.update
  end

  desc "Deletes expired content items"
  task :delete_expired => :environment do
    ContentItem.delete_expired
  end

  desc 'Deletes "overflow" Tweets'
  task :delete_overflow_tweets => :environment do
    ContentItem.delete_overflow_tweets
  end
end
