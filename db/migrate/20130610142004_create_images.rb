class CreateImages < ActiveRecord::Migration
  def up
    create_table(:images) do |table|
      table.string(:url, :null => false)
      table.integer(:width, :null => false)
      table.integer(:height, :null => false)

      table.timestamps
    end

    # To allow for longer URLs.
    execute("ALTER TABLE images ALTER COLUMN url TYPE character varying(1020);")
  end
end
