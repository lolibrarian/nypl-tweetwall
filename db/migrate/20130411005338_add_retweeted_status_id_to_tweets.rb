class AddRetweetedStatusIdToTweets < ActiveRecord::Migration
  def change
    Tweet.destroy_all
    add_column(:tweets, :retweeted_status_id, :integer, :limit => 8)
  end
end
