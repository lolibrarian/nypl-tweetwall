namespace :tweetwall do
  desc "Updates the Tweetwall"
  task :update => [
    "content_items:delete_expired",
    "tweets:delete_expired",
    "tweets:update",
    "content_items:update",
    :expire
  ]

  desc "Expires the Tweetwall page cache"
  task :expire do
    page_pathname = Pathname.new(Rails.public_path + "/index.html")
    page_pathname.delete if page_pathname.exist?
  end
end
