class RenameAcceptedToVisited < ActiveRecord::Migration[7.0]
  def change
    rename_column :notifications, :accepted, :visited
  end
end
