class RemoveOpenFromPlaces < ActiveRecord::Migration[7.0]
  def change
    remove_column :places, :open
  end
end
