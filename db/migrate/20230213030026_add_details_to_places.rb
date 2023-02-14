class AddDetailsToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :google_place_id, :string
    add_column :places, :google_rating, :float
    add_column :places, :google_photo_url, :string
  end
end
