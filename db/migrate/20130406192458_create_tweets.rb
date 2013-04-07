class CreateTweets < ActiveRecord::Migration
  def up
    create_table(:tweets) do |table|
      table.string(:text, :null => false)
      table.string(:user_name, :null => false)
      table.string(:screen_name, :null => false)
      table.string(:profile_image_url, :null => false)
      table.integer(:status_id, :null => false)
      table.datetime(:tweet_created_at, :null => false)

      table.timestamps
    end

    # Allows for the storage of Twitter's large status ID values.
    change_column(:tweets, :status_id, :integer, :limit => 8)

    # To make status ID querying more efficient.
    add_index(:tweets, :status_id)

    # To protect against the same status ID from being stored twice.
    execute("ALTER TABLE tweets ADD CONSTRAINT unique_status_id unique(status_id)")
  end
end
