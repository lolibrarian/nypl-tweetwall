class AddDigitalGalleryContentItems < ActiveRecord::Migration
  def change
    create_table(:digital_gallery_content_items) do |table|
      table.string(:url, :null => false)
      table.string(:title, :null => false)
      table.string(:thumbnail_url, :null => false)
      table.integer(:image_id, :null => false)

      table.timestamps
    end

    # Allows for the storage of BiblioCommons large image ID values.
    change_column(:digital_gallery_content_items, :image_id, :integer, :limit => 4)

    # To make image ID querying more efficient.
    add_index(:digital_gallery_content_items, :image_id)

    # To protect against the same image ID from being stored twice.
    execute("ALTER TABLE digital_gallery_content_items ADD CONSTRAINT unique_image_id unique(image_id)")
  end
end
