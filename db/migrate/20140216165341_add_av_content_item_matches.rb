class AddAvContentItemMatches < ActiveRecord::Migration
  def change
    create_table(:av_content_item_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:av_content_item, :null => false)
    end

    # To protect against the same match from being stored twice.
    add_index(:av_content_item_matches, [:tweet_id, :av_content_item_id], :name => :unique_av_content_match, :unique => true)
  end
end
