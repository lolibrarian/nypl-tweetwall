class AddDigitalCollectionsContentItems < ActiveRecord::Migration
  def change
    create_table(:digital_collections_content_items) do |table|
      table.string(:title, :null => false)
      table.integer(:thumbnail_id, :null => false)
      table.string(:mods_uuid, :limit => 36, :null => false)

      table.timestamps
    end

    # To make MODS UUID querying more efficient.
    add_index(:digital_collections_content_items, :mods_uuid)

    # To protect against the same mods UUID from being stored twice.
    execute("ALTER TABLE digital_collections_content_items ADD CONSTRAINT unique_mods_uuid unique(mods_uuid)")

    # Allow for longer title values.
    execute("ALTER TABLE digital_collections_content_items ALTER COLUMN title TYPE character varying(510);")
  end
end
