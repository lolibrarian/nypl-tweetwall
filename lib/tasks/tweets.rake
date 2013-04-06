namespace :tweets do
  task :update => :environment do
    BlogTweetSearch.new.search_and_save_results
  end
end
