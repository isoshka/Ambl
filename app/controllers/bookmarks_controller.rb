class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[new create destroy]

  def index
    @my_bookmarks = Bookmark.where(user_id: current_user.id)
    @interests = []
    @my_bookmarks.each do |bookmark|
      @interests << bookmark.interest
    end
    @my_bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @interests = Interest.where(name: bookmark_params[:interest])
    @interests.each do |interest|
      @bookmark = Bookmark.new(interest: interest)
      @bookmark.user = current_user
      @bookmark.save
    end
    redirect_to bookmarks_path
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
      5.0 # fallback to 3km
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
      place = @places.first
      message = "Hey, you're near #{place.name} at #{place.address}!. It has a rating of #{place.google_rating} and is #{place.distance.round(2)}km away." \
        " Get directions here: #{place_url(place)}"
      @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: current_user.phone_number,
        body: message
      )
      sleep(5)
      flash[:notice] = "A notification was sent to your phone and on the page."

    end
    # render the nearby places
    render json: @places
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path, status: :see_other
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def bookmark_params
    params.require(:bookmark).permit(:interest => [])
  end
end
