class DropBiblioCommonsTables < ActiveRecord::Migration
  def up
    drop_table :biblio_commons_list_content_items
    drop_table :biblio_commons_list_content_matches
    drop_table :biblio_commons_title_content_items
    drop_table :biblio_commons_title_content_matches
  end
end
