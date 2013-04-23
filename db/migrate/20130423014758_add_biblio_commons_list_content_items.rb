class AddBiblioCommonsListContentItems < ActiveRecord::Migration
  def change
    create_table(:biblio_commons_list_content_items) do |table|
      table.string(:title, :null => false)
      table.string(:thumbnail_url, :null => false)
      table.integer(:list_id, :null => false)
      table.integer(:user_id, :null => false)

      table.timestamps
    end

    # Allows for the storage of BiblioCommons large list and user ID values.
    change_column(:biblio_commons_list_content_items, :list_id, :integer, :limit => 8)
    change_column(:biblio_commons_list_content_items, :user_id, :integer, :limit => 8)

    # To make list ID querying more efficient.
    add_index(:biblio_commons_list_content_items, :list_id)

    # To protect against the same list ID from being stored twice.
    execute("ALTER TABLE biblio_commons_list_content_items ADD CONSTRAINT unique_list_id unique(list_id)")

    # To allow for longer thumbnail URLs and titles.
    execute("ALTER TABLE biblio_commons_list_content_items ALTER COLUMN thumbnail_url TYPE character varying(1020);")
    execute("ALTER TABLE biblio_commons_list_content_items ALTER COLUMN title TYPE character varying(510);")
  end
end
