class LengthenTitleColumns < ActiveRecord::Migration
  def change
    %w(digital_gallery_content_items blog_content_items biblio_commons_content_items).each do |table|
      execute("ALTER TABLE #{table} ALTER COLUMN title TYPE character varying(510);")
    end
  end
end
