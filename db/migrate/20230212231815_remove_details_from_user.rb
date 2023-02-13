class RemoveDetailsFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :thirty_minutes, :string
    remove_column :users, :one_hour, :string
    remove_column :users, :two_hours, :string
    remove_column :users, :one_hundred_metres, :string
    remove_column :users, :five_hundred_metres, :string
    remove_column :users, :one_kilometer, :string
  end
end
