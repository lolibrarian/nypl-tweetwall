class AddProgramContentMatches < ActiveRecord::Migration
  def change
    create_table(:program_content_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:program_content_item, :null => false)
    end

    # To protect against the same match from being stored twice.
    add_index(:program_content_matches, [:tweet_id, :program_content_item_id], :name => :unique_program_content_match, :unique => true)
  end
end
