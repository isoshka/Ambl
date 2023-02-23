class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [ :new, :create, :destroy ]

  def index
    @my_bookmarks = Bookmark.where(user_id: current_user.id)
    @interests = []
    @my_bookmarks.each do |bookmark|
      @interests << bookmark.interest
    end
    @interests
  end

  def new

  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
  end

  def nearby
    latitude = params[:latitude]
    longitude = params[:longitude]

    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    # # get the nearby bookmarks
    @interest_ids = []
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @bookmarks.each do |bookmark|
      @interest_ids << bookmark.interest_id
    end

    # origin_lat = current_user.latitude
    # origin_lng = current_user.longitude
    # dest_lat = place.lat
    # dest_lng = place.lng

    # @places = Place.near([latitude, longitude], 3).where(interest_id: @interest_ids)
    @places = Place.near([latitude, longitude], 1, latitude: :lat, longitude: :lng).where(interest_id: @interest_ids)
    if @place.present?
      message = "Hey, you're near #{@place.name} at #{@place.address}.
      # https://www.google.com/maps/dir/?api=1&origin=#{origin_lat},#{origin_lng}&destination=#{dest_lat},#{dest_lng}"

      @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: current_user.phone_number,
        body: message
      )
    end

    # render the closest place
    render json: @place
  end

  def destroy
    @bookmark.destroy
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.find(params[:id])
  end

end
