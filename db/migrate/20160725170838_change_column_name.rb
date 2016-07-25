class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :microposts, :picture, :media
  end
end
