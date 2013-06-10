class AddThumbnailIdColumns < ActiveRecord::Migration
  def change
    %w(digital_gallery_content_items blog_content_items biblio_commons_title_content_items biblio_commons_list_content_items).each do |table|
      add_column(table, :thumbnail_id, :integer)
    end
  end
end
