class AddBlogContentMatches < ActiveRecord::Migration
  def change
    create_table(:blog_content_matches) do |table|
      table.belongs_to(:tweet, :null => false)
      table.belongs_to(:blog_content_item, :null => false)
    end

    add_index(:blog_content_matches, [:tweet_id, :blog_content_item_id])

    # To protect against the same match from being stored twice.
    execute("ALTER TABLE blog_content_matches ADD CONSTRAINT unique_blog_content_match unique(tweet_id, blog_content_item_id)")
  end
end
