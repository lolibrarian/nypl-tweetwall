class RenameImagesToRemoteImages < ActiveRecord::Migration
  def change
    rename_table(:images, :remote_images)
  end
end
