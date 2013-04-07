class AddDigitalGalleryContentMatches < ActiveRecord::Migration
  def change
    create_table(:digital_gallery_content_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:digital_gallery_content_item, :null => false)
    end

    add_index(:digital_gallery_content_matches, [:tweet_id, :digital_gallery_content_item_id], :name => :index_digital_gallery_content_matches_on_tweet_and_content_item)

    # To protect against the same match from being stored twice.
    execute("ALTER TABLE digital_gallery_content_matches ADD CONSTRAINT unique_digital_gallery_content_match unique(tweet_id, digital_gallery_content_item_id)")
  end
end
