class CreateBlogContentItems < ActiveRecord::Migration
  def change
    create_table(:blog_content_items) do |table|
      table.string(:url, :null => false)
      table.string(:title, :null => false)
      table.string(:thumbnail_url, :null => false)
      table.string(:blog_id, :null => false)

      table.timestamps
    end

    # To make blog ID querying more efficient.
    add_index(:blog_content_items, :blog_id)

    # To protect against the same blog ID from being stored twice.
    execute("ALTER TABLE blog_content_items ADD CONSTRAINT unique_blog_id unique(blog_id)")
  end
end
