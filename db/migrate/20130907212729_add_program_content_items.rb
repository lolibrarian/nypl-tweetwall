class AddProgramContentItems < ActiveRecord::Migration
  def change
    create_table(:program_content_items) do |table|
      table.string(:title, :null => false)
      table.integer(:thumbnail_id, :null => false)
      table.string(:program_id, :null => false)

      table.timestamps
    end

    # To protect against the same program ID from being stored twice.
    add_index(:program_content_items, :program_id, :unique => true)

    # To allow for longer title values.
    execute("ALTER TABLE program_content_items ALTER COLUMN title TYPE character varying(510);")
  end
end
