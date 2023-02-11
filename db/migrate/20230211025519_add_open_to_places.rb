class AddOpenToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :open, :boolean
  end
end
