class AddBiblioCommonsContentItems < ActiveRecord::Migration
  def change
    create_table(:biblio_commons_content_items) do |table|
      table.string(:url, :null => false)
      table.string(:title, :null => false)
      table.string(:thumbnail_url, :null => false)
      table.integer(:title_id, :null => false)

      table.timestamps
    end

    # Allows for the storage of BiblioCommons large title ID values.
    change_column(:biblio_commons_content_items, :title_id, :integer, :limit => 8)

    # To make title ID querying more efficient.
    add_index(:biblio_commons_content_items, :title_id)

    # To protect against the same title ID from being stored twice.
    execute("ALTER TABLE biblio_commons_content_items ADD CONSTRAINT unique_title_id unique(title_id)")
  end
end
