class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :thirty_minutes, :boolean
    add_column :users, :one_hour, :boolean
    add_column :users, :two_hours, :boolean
    add_column :users, :one_hundred_metres, :boolean
    add_column :users, :five_hundred_metres, :boolean
    add_column :users, :one_kilometer, :boolean
  end
end
