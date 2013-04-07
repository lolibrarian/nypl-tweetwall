namespace :tweets do
  task :update => :environment do
    blog_tweet_search = BlogTweetSearch.new
    blog_tweet_search.search_and_save_results

    Tweet.find_in_batches do |batch|
      batch.each do |tweet|
        BlogContentMatch.find_or_create_content_items(tweet)
      end
    end
  end
end
