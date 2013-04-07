class AddBiblioCommonsContentMatches < ActiveRecord::Migration
  def change
    create_table(:biblio_commons_content_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:biblio_commons_content_item, :null => false)
    end

    add_index(:biblio_commons_content_matches, [:tweet_id, :biblio_commons_content_item_id], :name => :index_biblio_commons_content_matches_on_tweet_and_content_item)

    # To protect against the same match from being stored twice.
    execute("ALTER TABLE biblio_commons_content_matches ADD CONSTRAINT unique_biblio_commons_content_match unique(tweet_id, biblio_commons_content_item_id)")
  end
end
