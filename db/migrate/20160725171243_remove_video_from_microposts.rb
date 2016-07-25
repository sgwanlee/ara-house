class RemoveVideoFromMicroposts < ActiveRecord::Migration
  def change
    remove_column :microposts, :video
  end
end
