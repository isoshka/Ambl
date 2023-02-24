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

    distance = User::DISTANCE.index(current_user.distance) # get the index of the selected distance
    max_distance = case distance # set the maximum distance based on the index
    when "100 meters"
      0.1 # 100 meters
    when "500 meters"
      0.5 # 500 meters
    when "1km"
      1.0 # 1km
    else
      3.0 # fallback to 3km
    end

    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    # # get the nearby bookmarks
    @interest_ids = []
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @bookmarks.each do |bookmark|
      @interest_ids << bookmark.interest_id
    end

    @places = Place.near([latitude, longitude], max_distance, latitude: :lat, longitude: :lng).where(interest_id: @interest_ids)
    if @places.present?
      @places.each do |place|
        message = "Hey, you're near #{place.name} at #{place.address}!. It has a rating of #{place.google_rating} and is #{place.distance.round(2)}km away." \
        " Get directions here: #{place_url(place)}"
        @client.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: current_user.phone_number,
          body: message
        )
        # exit the loop after sending the message for the first place
        break
      end

    end
    # render the nearby places
    render json: @places
  end


  def destroy
    @bookmark.destroy
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.find(params[:id])
  end

end
