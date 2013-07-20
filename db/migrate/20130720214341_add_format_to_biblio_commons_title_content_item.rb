class AddFormatToBiblioCommonsTitleContentItem < ActiveRecord::Migration
  def change
    BiblioCommonsTitleContentItem.destroy_all
    add_column(:biblio_commons_title_content_items, :format, :string, :null => false)
  end
end
