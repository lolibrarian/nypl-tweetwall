class AddAvContentItems < ActiveRecord::Migration
  def change
    create_table(:av_content_items) do |table|
      table.string(:title, :null => false)
      table.integer(:thumbnail_id, :null => false)
      table.string(:av_id, :null => false)

      table.timestamps
    end

    # To protect against the same program ID from being stored twice.
    add_index(:av_content_items, :av_id, :unique => true)

    # To allow for longer title values.
    execute("ALTER TABLE av_content_items ALTER COLUMN title TYPE character varying(510);")
  end
end
