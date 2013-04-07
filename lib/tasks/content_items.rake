namespace :content_items do
  desc "Updates content items (associated with Tweets)"
  task :update => :environment do
    ContentMatch.update
  end

  desc "Deletes expired content items"
  task :delete_expired => :environment do
    ContentItem.expire_all
  end
end
