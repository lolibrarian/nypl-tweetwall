class CreateTweetUrls < ActiveRecord::Migration
  def change
    create_table(:tweet_urls) do |table|
      table.string(:original_url, :null => false)
      table.string(:expanded_url, :null => false)
      table.belongs_to(:tweet)

      table.timestamps
    end

    add_index(:tweet_urls, :tweet_id)
  end
end
