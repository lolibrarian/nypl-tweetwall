class RenameBiblioCommonsContentItem < ActiveRecord::Migration
  def change
    remove_index(:biblio_commons_content_matches, :name => :index_biblio_commons_content_matches_on_tweet_and_content_item)
    execute("ALTER TABLE biblio_commons_content_matches DROP CONSTRAINT unique_biblio_commons_content_match")
    rename_table(:biblio_commons_content_items, :biblio_commons_title_content_items)
    rename_index(:biblio_commons_title_content_items, :index_biblio_commons_content_items_on_title_id, :index_biblio_commons_title_content_items_on_title_id)
    rename_table(:biblio_commons_content_matches, :biblio_commons_title_content_matches)
    rename_column(:biblio_commons_title_content_matches, :biblio_commons_content_item_id, :biblio_commons_title_content_item_id)
    execute("ALTER TABLE biblio_commons_title_content_matches ADD CONSTRAINT unique_biblio_commons_title_content_match unique(tweet_id, biblio_commons_title_content_item_id)")
    add_index(:biblio_commons_title_content_matches, [:tweet_id, :biblio_commons_title_content_item_id], :name => :index_biblio_commons_title_content_matches_on_tweet_and_content)
  end
end
