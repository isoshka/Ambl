class PlacesController < ApplicationController
  def new
  end

  def show
    @place = Place.find(params[:id])
    @marker = {
        lat: @place.lat,
        lng: @place.lng
      }
  end
end
