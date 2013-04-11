class StoreDigitalGalleryIdsAsStrings < ActiveRecord::Migration
  def change
    change_column(:digital_gallery_content_items, :image_id, :string)
  end
end
