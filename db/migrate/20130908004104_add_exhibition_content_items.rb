class AddExhibitionContentItems < ActiveRecord::Migration
  def change
    create_table(:exhibition_content_items) do |table|
      table.string(:title, :null => false)
      table.integer(:thumbnail_id, :null => false)
      table.string(:exhibition_id, :null => false)

      table.timestamps
    end

    # To protect against the same program ID from being stored twice.
    add_index(:exhibition_content_items, :exhibition_id, :unique => true)

    # To allow for longer title values.
    execute("ALTER TABLE exhibition_content_items ALTER COLUMN title TYPE character varying(510);")
  end
end
