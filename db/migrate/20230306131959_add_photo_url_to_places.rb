class AddPhotoUrlToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :photo_url, :string
  end
end
