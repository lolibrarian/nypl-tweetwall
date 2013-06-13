class DestroyContentItems < ActiveRecord::Migration
  def change
    ContentItem.classes.each do |klass|
      klass.destroy_all if table_exists?(klass.table_name)
    end
  end
end
