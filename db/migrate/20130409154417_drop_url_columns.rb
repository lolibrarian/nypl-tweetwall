class DropUrlColumns < ActiveRecord::Migration
  def up
    %w(digital_gallery_content_items blog_content_items biblio_commons_content_items).each do |table|
      remove_column table, :url
    end

    remove_column "digital_gallery_content_items", :thumbnail_url
  end
end
