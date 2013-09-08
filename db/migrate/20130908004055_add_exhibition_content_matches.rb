class AddExhibitionContentMatches < ActiveRecord::Migration
  def change
    create_table(:exhibition_content_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:exhibition_content_item, :null => false)
    end

    # To protect against the same match from being stored twice.
    add_index(:exhibition_content_matches, [:tweet_id, :exhibition_content_item_id], :name => :unique_exhibition_content_match, :unique => true)
  end
end
