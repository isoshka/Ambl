class PlacesController < ApplicationController
  def new
  end

  def show
    @place = Place.find(params[:id])
  end

end
