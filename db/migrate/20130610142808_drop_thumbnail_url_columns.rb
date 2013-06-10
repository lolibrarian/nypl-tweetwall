class DropThumbnailUrlColumns < ActiveRecord::Migration
  def change
    %w(blog_content_items biblio_commons_title_content_items biblio_commons_list_content_items).each do |table|
      execute("ALTER TABLE #{table} DROP COLUMN thumbnail_url;")
    end
  end
end
