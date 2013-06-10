class DestroyContentItems < ActiveRecord::Migration
  def change
    ContentItem.classes.each { |klass| klass.destroy_all }
  end
end
