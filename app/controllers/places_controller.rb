class PlacesController < ApplicationController
  before_action :authenticate_user!, only: :toggle_favorite

  def new
  end

  def toggle_favorite
    @place = Place.find(params[:id])
    current_user.favorited?(@place) ? current_user.unfavorite(@place) : current_user.favorite(@place)
    redirect_to places_path
  end

  def index
    @places = Place.all
    @favorite_places = current_user.favorited_by_type('Place')
    @markerfav = @favorite_places.map do |place|
      {
        lat: place.lat,
        lng: place.lng
      }
    end
  end

  def show
    @place = Place.find(params[:id])
    @marker = {
      lat: @place.lat,
      lng: @place.lng
    }
  end

  def destroy
    @favorite_places = current_user.favorited_by_type('Place')
    @favorite_places.destroy

    redirect_to places_url, notice: "Place was successfully deleted."
  end
end
