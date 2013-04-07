class LengthenUrlColumns < ActiveRecord::Migration
  def up
    [["tweet_urls", "original_url"],
    ["tweet_urls", "expanded_url"],
    ["digital_gallery_content_items", "url"],
    ["digital_gallery_content_items", "thumbnail_url"],
    ["blog_content_items", "url"],
    ["blog_content_items", "thumbnail_url"],
    ["biblio_commons_content_items", "url"],
    ["biblio_commons_content_items", "thumbnail_url"]].each do |table, column|
      execute("ALTER TABLE #{table} ALTER COLUMN #{column} TYPE character varying(1020);")
    end
  end
end
