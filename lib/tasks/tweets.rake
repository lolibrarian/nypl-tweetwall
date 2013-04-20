namespace :tweets do
  desc "Updates Tweets"
  task :update => :environment do
    TweetSearch.update
  end

  desc "Deletes expired Tweets"
  task :delete_expired => :environment do
    Tweet.expired.destroy_all
  end

  desc "Deletes blocked Tweets"
  task :delete_blocked => :environment do
    Tweet.blocked.destroy_all
  end
end
