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
    # @markers = @places.map do |place|
    #   {
    #     lat: place.latitude,
    #     lng: place.longitude,
    #     info_window_html: render_to_string(partial: "info_window", locals: {place: place}),
    #     # image_url: helpers.asset_url("logo.png"),
    #     marker_html: render_to_string(partial: "marker", locals: {place:place})
    #   }
    # end
  end


  def show
    @place = Place.find(params[:id])
    @marker = {
      lat: @place.lat,
      lng: @place.lng
    }
  end

end
