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
    @my_bookmarks = Bookmark.where(user_id: current_user.id)
    if @my_bookmarks.length < 3
      new_bookmark_params = bookmark_params
      new_bookmark_params[:user_id] = current_user.id
      @my_bookmarks.each do |bookmark|
        not_unique = (bookmark.interest.id == new_bookmark_params[:interest_id].to_i)
        return "Try another one." if not_unique
      end
      @bookmark = Bookmark.new(new_bookmark_params)
      if @bookmark.save
        redirect_to bookmarks_path
      else
        render :new
      end
    else
      "Limit reached, sorry."
    end
    # this is how to create Bookmark.create(interest_id: 8, user_id: 6)

    # how does this code fit in?
    # @existing_interests = Bookmark.find(params[:user_id])
    # @existing_interests.length
    # if @existing_interests.length > 3
    # return “You can only pick 3 interests”
    # else < 3
    # @interests = params[:interests]
    # @interests.each do |interest|
    # @existing_interests find it exist
    # if it doesnt save
    # end
    # if @interests.length > 3
    # return “You can only pick 3 interests”
    # else < 3
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
    redirect_to interests_path(@bookmark.list), status: :see_other
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def bookmark_params
    params.require(:bookmark).permit(:interest_id)
  end
end
