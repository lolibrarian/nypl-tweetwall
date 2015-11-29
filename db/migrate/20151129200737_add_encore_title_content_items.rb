class AddEncoreTitleContentItems < ActiveRecord::Migration
  def change
    create_table :encore_title_content_items do |table|
      table.text :title, null: false
      table.belongs_to :thumbnail, null: false
      table.text :bib_id, null: false
      table.text :format, null: false

      table.timestamps
    end

    add_index :encore_title_content_items, :bib_id, unique: true
  end
end
