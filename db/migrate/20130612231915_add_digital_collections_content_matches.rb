class AddDigitalCollectionsContentMatches < ActiveRecord::Migration
  def change
    create_table(:digital_collections_content_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:digital_collections_content_item, :null => false)
    end

    add_index(:digital_collections_content_matches, [:tweet_id, :digital_collections_content_item_id], :name => :index_digital_collections_content_matches_on_tweet_and_content)

    # To protect against the same match from being stored twice.
    execute("ALTER TABLE digital_collections_content_matches ADD CONSTRAINT unique_digital_collections_content_match unique(tweet_id, digital_collections_content_item_id)")
  end
end
