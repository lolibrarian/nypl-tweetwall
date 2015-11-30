class AddEncoreTitleContentMatches < ActiveRecord::Migration
    def change
      create_table :encore_title_content_matches do |table|
        table.belongs_to :tweet, null: false
        table.belongs_to :encore_title_content_item, null: false
      end

      add_index :encore_title_content_matches,
                [:tweet_id, :encore_title_content_item_id],
                name: :unique_encore_title_content_match,
                unique: true
    end
end
